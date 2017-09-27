import Foundation

struct MVitaPtpMessageOutRequestSettings:MVitaPtpMessageOutProtocol
{
    let data:Data
    
    init(event:MVitaPtpMessageInEvent)
    {
        let builder:MVitaPtpMessageOutBuilder = MVitaPtpMessageOutBuilder()
        builder.append(value:MVitaPtpType.command.rawValue)
        builder.append(value:MVitaPtpDataPhase.request.rawValue)
        builder.append(value:MVitaPtpCommand.requestSettings.rawValue)
        builder.appendTransactionId()
        builder.append(value:event.eventId)
        
        data = builder.export()
    }
}
