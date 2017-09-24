import Foundation

struct MVitaPtpMessageOutPacketEnd:MVitaPtpMessageOutProtocol
{
    let data:Data
    
    init(packetData:Data)
    {
        let builder:MVitaPtpMessageOutBuilder = MVitaPtpMessageOutBuilder()
        builder.append(value:MVitaPtpType.dataPacketEnd.rawValue)
        builder.appendTransactionId()
        builder.append(data:packetData)
        
        data = builder.export()
    }
}
