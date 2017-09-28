import Foundation

struct MVitaPtpMessageOutItemProperty:MVitaPtpMessageOutProtocol
{
    let data:Data
    
    init(
        itemTreat:MVitaItemTreat,
        dataPhase:MVitaPtpDataPhase,
        property:MVitaPtpItemProperty)
    {
        let builder:MVitaPtpMessageOutBuilder = MVitaPtpMessageOutBuilder()
        builder.append(value:MVitaPtpType.command.rawValue)
        builder.append(value:dataPhase.rawValue)
        builder.append(value:MVitaPtpCommand.requestItemPropertyValue.rawValue)
        builder.appendTransactionId()
        builder.appendTransactionId()
        builder.append(value:itemTreat.treatId)
        builder.append(value:property.rawValue)
        
        data = builder.export()
    }
}
