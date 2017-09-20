import Foundation

final class MVitaPtpMessageInOpenSession:MVitaPtpMessageIn
{
    let code:UInt16
    let transactionId:UInt32
    
    override init?(
        header:MVitaPtpMessageInHeader,
        data:Data)
    {
        let codeSize:Int = MemoryLayout.size(ofValue:UInt16.self)
        let transactionSize:Int = MemoryLayout.size(ofValue:UInt32.self)
        let expectedSize:Int = codeSize + transactionSize
        
        guard
            
            data.count == expectedSize
            
        else
        {
            return nil
        }
        
        let rangeTransaction:Range<Data.Index> = Range<Data.Index>(
            codeSize ..< data.count)
        let subdataTransaction:Data = data.subdata(in:rangeTransaction)
        
        let arrayCode:[UInt16] = data.withUnsafeBytes
        { (pointer:UnsafePointer<UInt16>) -> [UInt16] in
            
            let bufferPointer:UnsafeBufferPointer = UnsafeBufferPointer(
                start:pointer,
                count:1)
            let array:[UInt16] = Array(bufferPointer)
            
            return array
        }
        
        let arrayTransaction:[UInt32] = subdataTransaction.withUnsafeBytes
        { (pointer:UnsafePointer<UInt32>) -> [UInt32] in
            
            let bufferPointer:UnsafeBufferPointer = UnsafeBufferPointer(
                start:pointer,
                count:1)
            let array:[UInt32] = Array(bufferPointer)
            
            return array
        }
        
        guard
            
            let code:UInt16 = arrayCode.first,
            let transactionId:UInt32 = arrayTransaction.first
            
        else
        {
            return nil
        }
        
        self.code = code
        self.transactionId = transactionId
        
        super.init(
            header:header,
            data:data)
    }
}
