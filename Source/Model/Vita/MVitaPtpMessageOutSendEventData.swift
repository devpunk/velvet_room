import Foundation

struct MVitaPtpMessageOutSendEventData:MVitaPtpMessageOutProtocol
{
    let data:Data
    
    init(event:MVitaPtpMessageInEvent)
    {
        let builder:MVitaPtpMessageOutBuilder = MVitaPtpMessageOutBuilder()
        builder.append(value:MVitaPtpType.command.rawValue)
        builder.append(value:MVitaPtpDataPhase.send.rawValue)
        builder.append(value:MVitaPtpCommand.sendStorageSize)
        builder.appendTransactionId()
        builder.append(value:event.eventId)
        
        data = builder.export()
    }
}
