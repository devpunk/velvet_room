import Foundation

struct MVitaPtpMessageOutGenericCommand:MVitaPtpMessageOutProtocol
{
    let data:Data
    
    init(
        dataPhase:MVitaPtpDataPhase,
        command:MVitaPtpCommand)
    {
        let builder:MVitaPtpMessageOutBuilder = MVitaPtpMessageOutBuilder()
        builder.append(value:MVitaPtpType.command.rawValue)
        builder.append(value:dataPhase.rawValue)
        builder.append(value:command.rawValue)
        builder.appendTransactionId()
        
        data = builder.export()
    }
}
