import Foundation

struct MVitaPtpMessageOutRequestEvent:MVitaPtpMessageOutProtocol
{
    let data:Data
    
    init(requestCommand:MVitaPtpMessageInRequestCommand)
    {
        let builder:MVitaPtpMessageOutBuilder = MVitaPtpMessageOutBuilder()
        builder.append(value:MVitaPtpType.eventRequest.rawValue)
        builder.append(value:requestCommand.eventPipeId)
        
        data = builder.export()
    }
}
