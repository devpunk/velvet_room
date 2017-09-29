import Foundation

struct MVitaPtpMessageOutItemElements:MVitaPtpMessageOutProtocol
{
    let data:Data
    private let kItemFormatCode:UInt32 = 0
    
    init(
        itemTreat:MVitaItemTreat,
        storageId:UInt32)
    {
        let builder:MVitaPtpMessageOutBuilder = MVitaPtpMessageOutBuilder()
        builder.append(value:MVitaPtpType.command.rawValue)
        builder.append(value:MVitaPtpDataPhase.request.rawValue)
        builder.append(value:MVitaPtpCommand.requestItemElements.rawValue)
        builder.appendTransactionId()
        builder.append(value:storageId)
        builder.append(value:kItemFormatCode)
        builder.append(value:itemTreat.treatId)
        
        data = builder.export()
    }
}
