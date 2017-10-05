import Foundation

struct MVitaPtpMessageOutSendItem:MVitaPtpMessageOutProtocol
{
    let data:Data
    
    init(
        storageId:UInt32,
        handle:UInt32)
    {
        let builder:MVitaPtpMessageOutBuilder = MVitaPtpMessageOutBuilder()
        builder.append(value:MVitaPtpType.command.rawValue)
        builder.append(value:MVitaPtpDataPhase.send.rawValue)
        builder.append(value:MVitaPtpCommand.sendItem.rawValue)
        builder.appendTransactionId()
        builder.append(value:storageId)
        builder.append(value:handle)
        
        data = builder.export()
    }
}
