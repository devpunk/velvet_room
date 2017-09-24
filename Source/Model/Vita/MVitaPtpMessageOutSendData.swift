import Foundation

struct MVitaPtpMessageOutSendData:MVitaPtpMessageOutProtocol
{
    let data:Data
    
    init(code:MVitaPtpCommand)
    {
        let builder:MVitaPtpMessageOutBuilder = MVitaPtpMessageOutBuilder()
        builder.append(value:MVitaPtpType.command.rawValue)
        builder.append(value:MVitaPtpDataPhase.send.rawValue)
        builder.append(value:code.rawValue)
        builder.appendTransactionId()
        
        data = builder.export()
    }
}
