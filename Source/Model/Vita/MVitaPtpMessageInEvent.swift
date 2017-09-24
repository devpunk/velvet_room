import Foundation

final class MVitaPtpMessageInEvent:MVitaPtpMessageIn
{
    let code:MVitaPtpCommand
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
            
            let rawCode:UInt16 = data.valueFromBytes(),
            let transactionId:UInt32 = subdataTransaction.valueFromBytes()
            
            else
        {
            return nil
        }
        
        if let code:MVitaPtpCommand = MVitaPtpCommand(
            rawValue:rawCode)
        {
            self.code = code
        }
        else
        {
            self.code = MVitaPtpCommand.unknown
        }
        
        self.transactionId = transactionId
        
        super.init(
            header:header,
            data:data)
    }
}

