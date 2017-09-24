import Foundation

struct MVitaPtpMessageOutRequestData:MVitaPtpMessageOutProtocol
{
    let data:Data
    
    init(code:UInt16)
    {
        let builder:MVitaPtpMessageOutBuilder = MVitaPtpMessageOutBuilder()
        builder.append(value:MVitaPtpType.command.rawValue)
        builder.append(value:MVitaPtpDataPhase.receive.rawValue)
        builder.append(value:code)
        builder.appendTransactionId()
        
        data = builder.export()
    }
}
