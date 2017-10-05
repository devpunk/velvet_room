import Foundation

struct MVitaPtpMessageOutSendItem:MVitaPtpMessageOutProtocol
{
    let data:Data
    
    init(
        event:MVitaPtpMessageInEvent,
        count:Int)
    {
        let unsignedCount:UInt32 = UInt32(count)
        
        let builder:MVitaPtpMessageOutBuilder = MVitaPtpMessageOutBuilder()
        builder.append(value:MVitaPtpType.command.rawValue)
        builder.append(value:MVitaPtpDataPhase.none.rawValue)
        builder.append(value:MVitaPtpCommand.sendItemsCount.rawValue)
        builder.appendTransactionId()
        builder.append(value:event.eventId)
        builder.append(value:unsignedCount)
        
        data = builder.export()
    }
}
