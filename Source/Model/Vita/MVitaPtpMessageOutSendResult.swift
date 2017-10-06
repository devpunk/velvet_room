import Foundation

struct MVitaPtpMessageOutSendResult:MVitaPtpMessageOutProtocol
{
    let data:Data
    
    init(
        event:MVitaPtpMessageInEvent,
        result:MVitaPtpResult,
        parameters:[UInt32])
    {
        let builder:MVitaPtpMessageOutBuilder = MVitaPtpMessageOutBuilder()
        builder.append(value:MVitaPtpType.command.rawValue)
        builder.append(value:MVitaPtpDataPhase.none.rawValue)
        builder.append(value:MVitaPtpCommand.sendResult.rawValue)
        builder.appendTransactionId()
        builder.append(value:event.eventId)
        builder.append(value:result.rawValue)
        
        for parameter:UInt32 in parameters
        {
            builder.append(value:parameter)
        }
        
        data = builder.export()
    }
}
