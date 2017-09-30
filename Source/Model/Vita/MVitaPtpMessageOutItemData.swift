import Foundation

struct MVitaPtpMessageOutItemData:MVitaPtpMessageOutProtocol
{
    let data:Data
    
    init(
        treatId:UInt32,
        dataPhase:MVitaPtpDataPhase)
    {
        let builder:MVitaPtpMessageOutBuilder = MVitaPtpMessageOutBuilder()
        builder.append(value:MVitaPtpType.command.rawValue)
        builder.append(value:dataPhase.rawValue)
        builder.append(value:MVitaPtpCommand.requestItem.rawValue)
        builder.appendTransactionId()
        builder.append(value:treatId)
        
        data = builder.export()
    }
}
