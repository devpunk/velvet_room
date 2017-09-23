import Foundation

struct MVitaPtpMessageOutSendData:MVitaPtpMessageOutProtocol
{
    let data:Data
    
    init(code:UInt16)
    {
        let builder:MVitaPtpMessageOutBuilder = MVitaPtpMessageOutBuilder()
        builder.append(value:MVitaPtpType.command)
        builder.append(value:MVitaPtpDataPhase.send)
        builder.append(value:code)
        
        let tran:UInt32 = 5
        builder.append(value:tran)
        
        data = builder.export()
    }
}
