import Foundation
import CocoaAsyncSocket

class PTPDelegateWrite:NSObject, GCDAsyncSocketDelegate
{
    var transactionId:UInt32 = 0
    var step:Int = 0
    var dataToWrite:Data?
    var totalWritten:Int = 0
    let maxBlockSize:Int = 32756
    weak var connected:MConnectConnected?
    
    func socket(_ sock:GCDAsyncSocket, didWriteDataWithTag tag:Int)
    {
        if step == 0
        {
            step = 1
            
            sendStart(sock:sock)
        }
        else if step == 1
        {
            guard
                
                let dataToWrite:Data = self.dataToWrite
                
            else
            {
                return
            }
            
            let size:Int = dataToWrite.count
            let remain:Int = size - totalWritten
            let type:UInt32
            let toWrite:Int
            
            print("remain: \(remain)")
            
            if remain > maxBlockSize
            {
                print("send data")
                type = 10 //PTPIP_DATA_PACKET
                toWrite = maxBlockSize
            }
            else
            {
                print("end data")
                type = 12 //PTPIP_END_DATA_PACKET
                toWrite = remain
                step = 2
            }
            
            let endIndex:Int = toWrite + totalWritten
            let writingData:Data = dataToWrite.subdata(in:totalWritten..<endIndex)
            let length:UInt32 = UInt32(toWrite + 12)
            var pars:[UInt32] = [length, type, transactionId]
            
            var data:Data = Data()
            data.append(UnsafeBufferPointer(start:&pars, count:pars.count))
            data.append(writingData)
            
            totalWritten += toWrite
            
            sock.write(data, withTimeout:100, tag:0)
        }
        else if step == 2
        {
            connected?.capabilitiesSent()
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
        
        totalWritten = 0
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
