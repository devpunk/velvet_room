import Foundation

struct MVitaPtpMessageOutLocalStatus:MVitaPtpMessageOutProtocol
{
    let data:Data
    private let kSessionId:UInt32 = 1
    
    init()
    {
        let builder:MVitaPtpMessageOutBuilder = MVitaPtpMessageOutBuilder()
        builder.append(value:MVitaPtpType.command.rawValue)
        builder.append(value:MVitaPtpDataPhase.none.rawValue)
        builder.append(value:MVitaPtpCommand.openSession.rawValue)
        builder.appendTransactionId()
        builder.append(value:kSessionId)
        
        data = builder.export()
    }
}
