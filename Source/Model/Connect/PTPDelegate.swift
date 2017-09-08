import Foundation
import CocoaAsyncSocket

class PTPDelegate:NSObject, GCDAsyncSocketDelegate
{
    var step:Int = 0
    var dataReceived:Data?
    var carriedData:Data?
    weak var connected:MConnectConnected?
    
    func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?) {
        print(connected?.deviceInfo)
        print("command did disconnect error \(err?.localizedDescription)")
        
        connected?.commandDisconnected()
    }
    
    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        print("command did read size \(data.count)")
        
        if step == 0
        {
            step = 1
            
            if data.count != 12
            {
                print("error reading header, must be 12 bytes")
            }
            
            let arr2 = data.withUnsafeBytes {
                Array(UnsafeBufferPointer<UInt32>(start: $0, count: data.count/MemoryLayout<UInt32>.size))
            }
            
            // 0: length, 1: ack (should be 2), 2: eventpipeid
            
            print(arr2)
            
            connected?.commandAckRead()
        }
        else if step == 1
        {
            step = 2
            // open session
            
            let header = data.withUnsafeBytes {
                
                Array(UnsafeBufferPointer<UInt32>(start: $0, count: 2))
            }
            
            let sub:Data = data.subdata(in: 8..<10)
            
            let arrCode = sub.withUnsafeBytes {
                
                Array(UnsafeBufferPointer<UInt16>(start: $0, count: 1))
            }
            
            let sub2:Data = data.subdata(in: 10..<14)
            
            let arrParameter = sub2.withUnsafeBytes {
                
                Array(UnsafeBufferPointer<UInt32>(start: $0, count: 1))
            }
            
            //[size:14, response:7, code: 8193 (ok), transactionId:1]
            
            // par 1 == tranid
            print("header:\(header)")
            print("code: \(arrCode) par:\(arrParameter)")
            
            connected?.eventReadDataConnection()
        }
        else if step == 2
        {
            step = 3
            
            let header = data.withUnsafeBytes {
                
                Array(UnsafeBufferPointer<UInt32>(start: $0, count: 4))
            }
            
            //[size:16, response:9 // PTPIP_START_DATA_PACKET, transactionId:2, payload]
            
            //header and payload:[14, 7, 139267, 0]
            //header and payload:[14, 7, 204803, 0, 0]
            //header and payload:[14, 7, 139267, 0, 1879633920]
            //header and payload:[20, 9, 1, 407, 0]
            
            print("header and payload:\(header)")
            
            let subData:Data = data.subdata(in: 16..<data.count)
            let remainHeader = subData.withUnsafeBytes {
                
                Array(UnsafeBufferPointer<UInt32>(start: $0, count: 1))
            }
            
            print("remain header \(remainHeader)")
            
            self.data = Data()
            connected?.readCommand()
        }
        else if step == 3
        {
            let header = data.withUnsafeBytes {
                
                Array(UnsafeBufferPointer<UInt32>(start: $0, count: 3))
            }
            print("data:\(header)")
            
            let subData:Data = data.subdata(in: 12..<data.count)
            self.data?.append(subData)
            
            //[size, response:10 or 12]
            //10:PTPIP_DATA_PACKET
            //12:PTPIP_END_DATA_PACKET
            
            
            let type:UInt32 = header[1]
            
            if type == 12
            {
                step = 4
                
                if let receivingString:String = String(
                    data:data,
                    encoding:String.Encoding.utf8)
                {
                    print("data in xml:")
                    print(receivingString)
                }
                else
                {
                    print("can't create string")
                }
                
            }
            else if type == 10
            {
                print("------- read again")
            }
            else
            {
                print("error")
            }
            
            self.connected?.readCommand()
            
            // size should be equal to payload if not read again if true read to next step
        }
        else if step == 4
        {
            step = 5
            
            step = 2
            let header = data.withUnsafeBytes {
                
                Array(UnsafeBufferPointer<UInt32>(start: $0, count: 2))
            }
            
            let sub:Data = data.subdata(in: 8..<10)
            
            let arrCode = sub.withUnsafeBytes {
                
                Array(UnsafeBufferPointer<UInt16>(start: $0, count: 1))
            }
            
            let sub2:Data = data.subdata(in: 10..<14)
            
            let arrParameter = sub2.withUnsafeBytes {
                
                Array(UnsafeBufferPointer<UInt32>(start: $0, count: 1))
            }
            
            //[size:14, response:7, code: 8193 (ok), transactionId:1]
            
            // par 1 == tranid
            print("finish data header:\(header)")
            print("code: \(arrCode) par:\(arrParameter)")
            
            // response should be xml
            
        }
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
