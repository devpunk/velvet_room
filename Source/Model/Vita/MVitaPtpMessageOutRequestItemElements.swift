import Foundation

struct MVitaPtpMessageOutRequestItemElements:MVitaPtpMessageOutProtocol
{
    let data:Data
    private let kItemFormatCode:UInt32 = 0
    
    init(
        treatId:UInt32,
        storageId:UInt32)
    {
        let builder:MVitaPtpMessageOutBuilder = MVitaPtpMessageOutBuilder()
        builder.append(value:MVitaPtpType.command.rawValue)
        builder.append(value:MVitaPtpDataPhase.request.rawValue)
        builder.append(value:MVitaPtpCommand.requestItemElements.rawValue)
        builder.appendTransactionId()
        builder.append(value:storageId)
        builder.append(value:kItemFormatCode)
        builder.append(value:treatId)
        
        data = builder.export()
    }
}
