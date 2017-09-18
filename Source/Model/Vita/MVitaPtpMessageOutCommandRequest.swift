import Foundation

struct MVitaPtpMessageOutCommandRequest:MVitaPtpMessageOutProtocol
{
    let data:Data
    
    init()
    {
        let builder:MVitaPtpMessageOutBuilder = MVitaPtpMessageOutBuilder()
        builder.append(value:MVitaPtpType.commandRequest)
        builder.append(value:MVitaPtpDataPhase.none)
        builder.appendTransactionId()
        
        data = builder.export()
    }
}
