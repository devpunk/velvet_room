import Foundation

struct MVitaPtpMessageOutRequestVitaInfo:MVitaPtpMessageOutProtocol
{
    let data:Data
    
    init()
    {
        let builder:MVitaPtpMessageOutBuilder = MVitaPtpMessageOutBuilder()
        builder.append(value:MVitaPtpType.command)
        builder.append(value:MVitaPtpDataPhase.receive)
        builder.append(value:MVitaPtpCommand.requestVitaInfo)
        builder.appendTransactionId()
        
        data = builder.export()
    }
}
