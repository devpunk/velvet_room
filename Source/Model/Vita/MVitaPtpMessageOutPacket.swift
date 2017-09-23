import Foundation

struct MVitaPtpMessageOutPacket:MVitaPtpMessageOutProtocol
{
    let data:Data
    
    init(packetData:Data)
    {
        let builder:MVitaPtpMessageOutBuilder = MVitaPtpMessageOutBuilder()
        builder.append(value:MVitaPtpType.dataPacket)
        builder.appendTransactionId()
        builder.append(data:packetData)
        
        data = builder.export()
    }
}
