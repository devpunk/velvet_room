import Foundation

struct MVitaPtpMessageOutRequestCommand:MVitaPtpMessageOutProtocol
{
    let data:Data
    private let kGuidStart:UInt32 = 0
    private let kGuidEnd:UInt32 = 0
    
    init()
    {
        let builder:MVitaPtpMessageOutBuilder = MVitaPtpMessageOutBuilder()
        builder.append(value:MVitaPtpType.commandRequest.rawValue)
        builder.append(value:MVitaPtpDataPhase.none.rawValue)
        builder.appendTransactionId()
        builder.append(value:kGuidStart)
        builder.append(value:kGuidEnd)
        
        data = builder.export()
    }
}
