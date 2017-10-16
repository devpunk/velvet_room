import Foundation

struct MVitaPtpMessageOutRequestItem:MVitaPtpMessageOutProtocol
{
    let data:Data
    
    init(treatId:UInt32)
    {
        let builder:MVitaPtpMessageOutBuilder = MVitaPtpMessageOutBuilder()
        builder.append(value:MVitaPtpType.command.rawValue)
        builder.append(value:MVitaPtpDataPhase.request.rawValue)
        builder.append(value:MVitaPtpCommand.requestItem.rawValue)
        builder.appendTransactionId()
        builder.append(value:treatId)
        
        data = builder.export()
    }
}
