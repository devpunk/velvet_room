import Foundation

struct MVitaPtpMessageOutRequestData:MVitaPtpMessageOutProtocol
{
    let data:Data
    
    init(code:UInt16)
    {
        let builder:MVitaPtpMessageOutBuilder = MVitaPtpMessageOutBuilder()
        builder.append(value:MVitaPtpType.command)
        builder.append(value:MVitaPtpDataPhase.receive)
        builder.append(value:code)
        builder.appendTransactionId()
        
        data = builder.export()
    }
}