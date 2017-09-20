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
        
        guard
            
            let code:UInt16 = data.valueFromBytes(),
            let transactionId:UInt32 = subdataTransaction.valueFromBytes()
            
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
