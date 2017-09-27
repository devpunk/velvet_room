import Foundation

struct MVitaPtpMessageOutEventCommand:MVitaPtpMessageOutProtocol
{
    let data:Data
    
    init(
        event:MVitaPtpMessageInEvent,
        dataPhase:MVitaPtpDataPhase,
        command:MVitaPtpCommand)
    {
        let builder:MVitaPtpMessageOutBuilder = MVitaPtpMessageOutBuilder()
        builder.append(value:MVitaPtpType.command.rawValue)
        builder.append(value:dataPhase.rawValue)
        builder.append(value:command.rawValue)
        builder.appendTransactionId()
        builder.append(value:event.eventId)
        
        data = builder.export()
    }
}
