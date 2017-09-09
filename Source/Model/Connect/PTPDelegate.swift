import Foundation
import CocoaAsyncSocket

class PTPDelegate:NSObject, GCDAsyncSocketDelegate
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
            
            if dataUnheader.count != 4
            {
                print("error reading header, must be 12 bytes")
            }
            
            let arr2 = dataUnheader.withUnsafeBytes {
                Array(UnsafeBufferPointer<UInt32>(start: $0, count: data.count/MemoryLayout<UInt32>.size))
            }
            
            // 0: length, 1: ack (should be 2), 2: eventpipeid
            
            print("header:\(header.size):\(header.type) pipeid:\(arr2)")
            
            defer
            {
                if readAgain
                {
                    connected?.commandAckRead()
                }
            }
        }
        else if step == 1
        {
            step = 2
            // open session
            
            let arrCode = dataUnheader.withUnsafeBytes {
                
                Array(UnsafeBufferPointer<UInt16>(start: $0, count: 1))
            }
            
            let sub2:Data = dataUnheader.subdata(in: 2..<6)
            
            let arrParameter = sub2.withUnsafeBytes {
                
                Array(UnsafeBufferPointer<UInt32>(start: $0, count: 1))
            }
            
            //[size:14, response:7, code: 8193 (ok), transactionId:1]
            
            // par 1 == tranid
            print("header:\(header.size):\(header.type)")
            print("code: \(arrCode) par:\(arrParameter)")
            
            defer
            {
                if readAgain
                {
                    connected?.eventReadDataConnection()
                }
            }
        }
        else if step == 2
        {
            step = 3
            
            let info = dataUnheader.withUnsafeBytes {
                
                Array(UnsafeBufferPointer<UInt32>(start: $0, count: 3))
            }
            
            //[size:16, response:9 // PTPIP_START_DATA_PACKET, transactionId:2, payload]
            
            //header and payload:[14, 7, 139267, 0]
            //header and payload:[14, 7, 204803, 0, 0]
            //header and payload:[14, 7, 139267, 0, 1879633920]
            //header and payload:[20, 9, 1, 407, 0]
            
            print("header and payload:\(header.size):\(header.type) \(info)")
            
            self.dataReceived = Data()
        
            defer
            {
                if readAgain
                {
                    connected?.readCommand()
                }
            }
        }
        else if step == 3
        {
            print("header:\(header.size):\(header.type)")
            
            let dataMinusTransaction:Data = dataUnheader.subdata(in:4..<dataUnheader.count)
            
            self.dataReceived?.append(dataMinusTransaction)
            
            //[size, response:10 or 12]
            //10:PTPIP_DATA_PACKET
            //12:PTPIP_END_DATA_PACKET
            
            if header.type == 12
            {
                step = 4
                let datareceived:Data = self.dataReceived!
                
                print("total data: \(datareceived.count)")
                
                
                if let receivingString:String = String(
                    data:datareceived,
                    encoding:String.Encoding.ascii)
                {
                    print("data in xml:")
                    print(receivingString)
                    
                    /**
 
                     <VITAInformation responderVersion="3.65" protocolVersion="01800010" comVersion="190" modelInfo="PCH02006ZA11" timezone="10"><photoThumb type="0" codecType="17" width="213" height="120"/><videoThumb type="1" codecType="5" width="213" height="120" duration="15"/><musicThumb type="0" codecType="17" width="192" height="192"/><gameThumb type="0" codecType="17" width="192" height="192"/></VITAInformation>
 
 ***/
                }
                else
                {
                    print("can't create string")
                }
                self.dataReceived = nil
            }
            else if header.type == 10
            {
                print("------- read again")
            }
            else
            {
                print("error header type: \(header.type)")
            }
            
            defer
            {
                if readAgain
                {
                    self.connected?.readCommand()
                }
            }
            
            // size should be equal to payload if not read again if true read to next step
        }
        else if step == 4
        {
            step = 5
            
            let arrCode = dataUnheader.withUnsafeBytes {
                
                Array(UnsafeBufferPointer<UInt16>(start: $0, count: 1))
            }
            
            let sub2:Data = dataUnheader.subdata(in: 2..<6)
            
            let arrParameter = sub2.withUnsafeBytes {
                
                Array(UnsafeBufferPointer<UInt32>(start: $0, count: 1))
            }
            
            //[size:14, response:7, code: 8193 (ok), transactionId:1]
            
            // par 1 == tranid
            print("finish data header:\(header.size):\(header.type)")
            print("code: \(arrCode) par:\(arrParameter)")
            
            // response should be xml
            connected?.sendCapabilities()
        }
    }
    
    func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?) {
        print(connected?.deviceInfo)
        print("command did disconnect error \(err?.localizedDescription)")
        
        connected?.commandDisconnected()
    }
    
    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        dataRead(data:data, sock:sock)
    }
    
    func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
        print("command did connect")
        
        connected?.commandConnected()
    }
}

class PTPHeader
{
    let size:UInt32
    let type:UInt32
    
    init?(data:Data)
    {
        guard
        
            data.count >= 8
        
        else
        {
            return nil
        }
        
        let array:[UInt32] = data.withUnsafeBytes
        {
            
            Array(UnsafeBufferPointer<UInt32>(start: $0, count: 2))
        }
        
        size = array[0]
        type = array[1]
    }
}
