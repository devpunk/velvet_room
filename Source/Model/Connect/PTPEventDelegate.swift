import Foundation
import CocoaAsyncSocket

class PTPEventDelegate:NSObject, GCDAsyncSocketDelegate
{
    weak var connected:MConnectConnected?
    var dataReceived:Data?
    var carriedData:Data?
    
    func carryData(data:Data)
    {
        if carriedData == nil
        {
            carriedData = Data()
        }
        
        carriedData?.append(data)
    }
    
    func mergeData(data:Data) -> Data
    {
        var merged:Data = Data()
        
        if let carriedData:Data = self.carriedData
        {
            merged.append(carriedData)
            self.carriedData = nil
        }
        
        merged.append(data)
        
        return merged
    }
    
    func start()
    {
        print("-----------------  start event")
        
        DispatchQueue.main.async
        {
//            Timer.scheduledTimer(timeInterval:0.1, target:self, selector:#selector(self.doRead), userInfo:nil, repeats:true)
            
            self.doRead()
        }
    }
    
    @objc func doRead()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            self.readWait()
        }
    }
    
    func readWait()
    {
        connected?.readEvent()
    }
    
    
    
    
    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        dataRead(data:data, sock:sock)
    }
    
    func dataRead(data:Data, sock: GCDAsyncSocket)
    {
        var readAgain:Bool = true
        print("event received:\(data.count)")
        let mergedData:Data = mergeData(data:data)
        
        guard
            
            let header:PTPHeader = PTPHeader(data:mergedData),
            header.type == 8, //PTPIP_EVENT,
            header.size <= mergedData.count
            
        else
        {
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            {
                self.carryData(data:mergedData)
                self.connected?.readEvent()
            }
            
            return
        }
        
        if header.size < mergedData.count
        {
            readAgain = false

            defer
            {
                DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
                    {
                        let sub:Data = mergedData.subdata(in:Int(header.size) ..< mergedData.count)
                        print("subdata: \(sub.count)")
                        self.dataRead(data:sub, sock:sock)
                }
            }
        }
        
        let dataUnheader:Data = mergedData.subdata(in:8 ..< Int(header.size))
      
        print("event header \(header.size) \(header.type)")
        
        let arrCode = dataUnheader.withUnsafeBytes {
            
            Array(UnsafeBufferPointer<UInt16>(start: $0, count: 1))
        }
        
        let subData1:Data = dataUnheader.subdata(in:2..<dataUnheader.count)
        
        let arrTrans = subData1.withUnsafeBytes {
            
            Array(UnsafeBufferPointer<UInt32>(start: $0, count: 1))
        }
        
        let subData2:Data = dataUnheader.subdata(in:6..<dataUnheader.count)
        let count:Int = subData2.count / 4
        
        let arrParameters = subData2.withUnsafeBytes {
            
            Array(UnsafeBufferPointer<UInt32>(start: $0, count:count))
        }
        
        print("------- event \(arrCode[0]) trans \(arrTrans[0]) pars:\(arrParameters)")
        
        if arrCode[0] == 49426
        {
            carriedData = nil
            dataReceived = nil
            getSettingInfo(eventId:arrParameters[0])
        }
    }
    
    func getSettingInfo(eventId:UInt32)
    {
        connected?.ptpDelegate2.getInfo(eventId:eventId)
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            {
                self.connected?.readEvent()
        }
    }
    
    func socket(_ sock: GCDAsyncSocket, shouldTimeoutReadWithTag tag: Int, elapsed: TimeInterval, bytesDone length: UInt) -> TimeInterval {
        print("timeo out")
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            {
                self.connected?.readEvent()
        }
        
        return -1
        
    }
    
    func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?) {
        print("disconnect error:\(err)")
    }
}

/*
 
 #define PTP_EC_VITA_RequestSendNumOfObject 0xC104 = 49412
 #define PTP_EC_VITA_RequestSendObjectMetadata 0xC105 = 49413
 #define PTP_EC_VITA_RequestSendObject 0xC107 = 49415
 #define PTP_EC_VITA_RequestCancelTask 0xC108 = 49416
 #define PTP_EC_VITA_RequestSendHttpObjectFromURL 0xC10B = 49416
 #define PTP_EC_VITA_Unknown1 0xC10D = 49421
 #define PTP_EC_VITA_RequestSendObjectStatus 0xC10F = 49423
 #define PTP_EC_VITA_RequestSendObjectThumb 0xC110 = 49424
 #define PTP_EC_VITA_RequestDeleteObject 0xC111 = 49425
 #define PTP_EC_VITA_RequestGetSettingInfo 0xC112 = 49426
 #define PTP_EC_VITA_RequestSendHttpObjectPropFromURL 0xC113 = 49427
 #define PTP_EC_VITA_RequestSendPartOfObject 0xC115 = 49429
 #define PTP_EC_VITA_RequestOperateObject 0xC117 = 49431
 #define PTP_EC_VITA_RequestGetPartOfObject 0xC118 = 49432
 #define PTP_EC_VITA_RequestSendStorageSize 0xC119 = 49433
 #define PTP_EC_VITA_RequestCheckExistance 0xC120 = 49440
 #define PTP_EC_VITA_RequestGetTreatObject 0xC122 = 49442
 #define PTP_EC_VITA_RequestSendCopyConfirmationInfo 0xC123 = 49443
 #define PTP_EC_VITA_RequestSendObjectMetadataItems 0xC124 = 49444
 #define PTP_EC_VITA_RequestSendNPAccountInfo 0xC125 = 49445
 #define PTP_EC_VITA_RequestTerminate 0xC126 = 49446
 
 */
