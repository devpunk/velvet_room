import Foundation

struct MVitaPtpMessageOutItemProperty:MVitaPtpMessageOutProtocol
{
    let data:Data
    
    init(
        treatId:UInt32,
        dataPhase:MVitaPtpDataPhase,
        property:MVitaPtpItemProperty)
    {
        let builder:MVitaPtpMessageOutBuilder = MVitaPtpMessageOutBuilder()
        builder.append(value:MVitaPtpType.command.rawValue)
        builder.append(value:dataPhase.rawValue)
        builder.append(value:MVitaPtpCommand.requestItemPropertyValue.rawValue)
        builder.appendTransactionId()
        builder.append(value:treatId)
        builder.append(value:property.rawValue)
        
        data = builder.export()
    }
}
