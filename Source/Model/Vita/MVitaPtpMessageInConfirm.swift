import Foundation

final class MVitaPtpMessageInConfirm:MVitaPtpMessageIn
{
    let code:UInt16
    let transactionId:UInt32
    
    override init?(
        header:MVitaPtpMessageInHeader,
        data:Data)
    {
        let codeSize:Int = MemoryLayout<UInt16>.size
        let transactionSize:Int = MemoryLayout<UInt32>.size
        let expectedSize:Int = codeSize + transactionSize
        
        guard
            
            data.count >= expectedSize
            
        else
        {
            return nil
        }
        
        let subdataTransaction:Data = data.subdata(
            start:codeSize)
        
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
