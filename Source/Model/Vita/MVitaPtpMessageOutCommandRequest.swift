import Foundation

struct MVitaPtpMessageOutCommandRequest:MVitaPtpMessageOutProtocol
{
    let data:Data
    
    init()
    {
        let builder:MVitaPtpMessageOutBuilder = MVitaPtpMessageOutBuilder()
        
        
        data = builder.export()
    }
}
