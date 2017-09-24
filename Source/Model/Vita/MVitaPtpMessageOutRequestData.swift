import Foundation

struct MVitaPtpMessageOutRequestData:MVitaPtpMessageOutProtocol
{
    let data:Data
    
    init(code:MVitaPtpCommand)
    {
        let builder:MVitaPtpMessageOutBuilder = MVitaPtpMessageOutBuilder()
        builder.append(value:MVitaPtpType.command.rawValue)
        builder.append(value:MVitaPtpDataPhase.receive.rawValue)
        builder.append(value:code.rawValue)
        builder.appendTransactionId()
        
        data = builder.export()
    }
}
