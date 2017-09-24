import Foundation

struct MVitaPtpMessageOutCloseSession:MVitaPtpMessageOutProtocol
{
    let data:Data
    
    init()
    {
        let builder:MVitaPtpMessageOutBuilder = MVitaPtpMessageOutBuilder()
        builder.append(value:MVitaPtpType.command.rawValue)
        builder.append(value:MVitaPtpDataPhase.none.rawValue)
        builder.append(value:MVitaPtpCommand.closeSession.rawValue)
        builder.appendTransactionId()
        
        data = builder.export()
    }
}
