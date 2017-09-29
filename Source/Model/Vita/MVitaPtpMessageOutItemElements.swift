import Foundation

struct MVitaPtpMessageOutItemElements:MVitaPtpMessageOutProtocol
{
    let data:Data
    private let kItemFormatCode:UInt32 = 0
    
    init(
        itemTreat:MVitaItemTreat,
        property:MVitaPtpItemProperty)
    {
        let builder:MVitaPtpMessageOutBuilder = MVitaPtpMessageOutBuilder()
        builder.append(value:MVitaPtpType.command.rawValue)
        builder.append(value:MVitaPtpDataPhase.request.rawValue)
        builder.append(value:MVitaPtpCommand.requestItemElements.rawValue)
        builder.appendTransactionId()
        builder.append(value:)
        builder.append(value:itemTreat.treatId)
        builder.append(value:property.rawValue)
        
        data = builder.export()
    }
}
