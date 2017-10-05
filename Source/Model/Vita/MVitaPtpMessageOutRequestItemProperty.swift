import Foundation

struct MVitaPtpMessageOutRequestItemProperty:MVitaPtpMessageOutProtocol
{
    let data:Data
    
    init(
        treatId:UInt32,
        property:MVitaPtpItemProperty)
    {
        let builder:MVitaPtpMessageOutBuilder = MVitaPtpMessageOutBuilder()
        builder.append(value:MVitaPtpType.command.rawValue)
        builder.append(value:MVitaPtpDataPhase.request.rawValue)
        builder.append(value:MVitaPtpCommand.requestItemPropertyValue.rawValue)
        builder.appendTransactionId()
        builder.append(value:treatId)
        builder.append(value:property.rawValue)
        
        data = builder.export()
    }
}
