import Foundation

struct MVitaPtpMessageOutItemData:MVitaPtpMessageOutProtocol
{
    let data:Data
    
    init(
        itemTreat:MVitaItemTreat,
        dataPhase:MVitaPtpDataPhase)
    {
        let builder:MVitaPtpMessageOutBuilder = MVitaPtpMessageOutBuilder()
        builder.append(value:MVitaPtpType.command.rawValue)
        builder.append(value:dataPhase.rawValue)
        builder.append(value:MVitaPtpCommand.requestItem.rawValue)
        builder.appendTransactionId()
        builder.append(value:itemTreat.treatId)
        
        data = builder.export()
    }
}
