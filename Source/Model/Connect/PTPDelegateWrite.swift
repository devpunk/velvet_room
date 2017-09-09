import Foundation
import CocoaAsyncSocket

class PTPDelegateWrite:NSObject, GCDAsyncSocketDelegate
{
    var step:Int = 0
    var dataToWrite:Data?
    
    func socket(_ sock:GCDAsyncSocket, didWriteDataWithTag tag:Int)
    {
        if step == 0
        {
            step = 1
            
            sendStart(sock:sock)
        }
    }
    
    func sendStart(sock:GCDAsyncSocket)
    {
        guard
            
            let dataToWrite:Data = self.dataToWrite
            
        else
        {
            return
        }
        
        let length:UInt32 = 20
        let sendType:UInt32 = 9 //PTPIP_START_DATA_PACKET
        let transId:UInt32 = 2
        let dataSize:UInt32 = UInt32(dataToWrite.count + 1) // plus one for null ending
        let start:UInt32 = 0
        var pars:[UInt32] = [length, sendType, transId, dataSize, start]
        
        var data = Data()
        data.append(UnsafeBufferPointer(start:&pars, count:pars.count))
        
        print("write send start")
        sock.write(data, withTimeout:100, tag:0)
    }
}
