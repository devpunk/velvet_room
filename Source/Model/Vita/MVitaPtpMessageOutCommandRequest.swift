import Foundation

struct MVitaPtpMessageOutCommandRequest:MVitaPtpMessageOutProtocol
{
    let data:Data
    
    init()
    {
        let builder:MVitaPtpMessageOutBuilder = MVitaPtpMessageOutBuilder()
        builder.append(value:MVitaPtpType.commandRequest)
        
        data = builder.export()
    }
}
