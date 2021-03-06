import Foundation

struct MVitaPtpMessageOutSendLocalStatus:MVitaPtpMessageOutProtocol
{
    let data:Data
    
    init(status:MVitaPtpLocalStatus)
    {
        let builder:MVitaPtpMessageOutBuilder = MVitaPtpMessageOutBuilder()
        builder.append(value:MVitaPtpType.command.rawValue)
        builder.append(value:MVitaPtpDataPhase.none.rawValue)
        builder.append(value:MVitaPtpCommand.sendLocalStatus.rawValue)
        builder.appendTransactionId()
        builder.append(value:status.rawValue)
        
        data = builder.export()
    }
}
