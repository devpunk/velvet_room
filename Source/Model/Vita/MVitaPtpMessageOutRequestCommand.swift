import Foundation

struct MVitaPtpMessageOutRequestCommand:MVitaPtpMessageOutProtocol
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
