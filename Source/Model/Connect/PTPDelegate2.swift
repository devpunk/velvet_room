import Foundation
import CocoaAsyncSocket

class PTPDelegate2:NSObject, GCDAsyncSocketDelegate
{
    var step:Int = 0
    var dataReceived:Data?
    var carriedData:Data?
    weak var connected:MConnectConnected?
    
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
    
    func dataRead(data:Data, sock: GCDAsyncSocket)
    {
        var readAgain:Bool = true
        print("received:\(data.count)")
        let mergedData:Data = mergeData(data:data)
        
        guard
            
            let header:PTPHeader = PTPHeader(data:mergedData),
            header.size <= mergedData.count
            
            else
        {
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
                {
                    self.carryData(data:mergedData)
                    self.connected?.readCommand()
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
        
        if step == 0
        {
            step = 1
        }
    }
    
    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        dataRead(data:data, sock:sock)
    }
    
    func getInfo(eventId:UInt32)
    {
        step = 0
        
        var code:UInt16 = 38180 // PTP_OC_VITA_GetSettingInfo
        let type:UInt32 = 6 // PTPIP_CMD_REQUEST
        let dataPhase:UInt32 = 2//ptpip_cmd_dataphase
        let tranId:UInt32 = 0//ptpip_cmd_transid
        
        var request:[UInt32] = [22,type,dataPhase]
        var transSession:[UInt32] = [tranId, eventId]
        
        var data = Data(buffer: UnsafeBufferPointer(start: &request, count: request.count))
        
        data.append(UnsafeBufferPointer(start:&code, count:1))
        data.append(UnsafeBufferPointer(start: &transSession, count: transSession.count))
        
        connected?.socketCommand?.write(data, withTimeout:100, tag:0)
        connected?.readCommand()
    }
}
