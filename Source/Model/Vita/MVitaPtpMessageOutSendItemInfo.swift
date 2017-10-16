import Foundation

struct MVitaPtpMessageOutSendItemInfo:MVitaPtpMessageOutProtocol
{
    let data:Data
    
    init(
        storageId:UInt32,
        parentHandle:UInt32)
    {
        let builder:MVitaPtpMessageOutBuilder = MVitaPtpMessageOutBuilder()
        builder.append(value:MVitaPtpType.command.rawValue)
        builder.append(value:MVitaPtpDataPhase.send.rawValue)
        builder.append(value:MVitaPtpCommand.sendItemInfo.rawValue)
        builder.appendTransactionId()
        builder.append(value:storageId)
        builder.append(value:parentHandle)
        
        data = builder.export()
    }
}
