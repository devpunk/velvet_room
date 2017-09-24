import Foundation

final class MVitaPtpMessageInEvent:MVitaPtpMessageIn
{
    let parameters:[UInt32]
    let code:MVitaPtpEvent
    let transactionId:UInt32
    
    override init?(
        header:MVitaPtpMessageInHeader,
        data:Data)
    {
        let codeSize:Int = MemoryLayout<UInt16>.size
        let parameterSize:Int = MemoryLayout<UInt32>.size
        let expectedSize:Int = codeSize + parameterSize
        
        guard
            
            data.count >= expectedSize
            
        else
        {
            return nil
        }
        
        let subdataTransaction:Data = data.subdata(
            start:codeSize)
        let subdataParameters:Data = data.subdata(
            start:expectedSize)
        let countParameters:Int = subdataParameters.count / parameterSize
        
        guard
            
            let rawCode:UInt16 = data.valueFromBytes(),
            let transactionId:UInt32 = subdataTransaction.valueFromBytes(),
            let parameters:[UInt32] = subdataParameters.arrayFromBytes(
                elements:countParameters)
            
        else
        {
            return nil
        }
        
        self.transactionId = transactionId
        self.parameters = parameters
        self.code = MVitaPtpMessageIn.factoryEventCode(
            rawCode:rawCode)
        
        super.init(
            header:header,
            data:data)
    }
}

