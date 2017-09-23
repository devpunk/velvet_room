import Foundation

struct MVitaPtpMessageOutPacket:MVitaPtpMessageOutProtocol
{
    let data:Data
    private let kStartingByte:UInt32 = 0
    
    init(packetData:Data)
    {
        let dataSizeUnsigned:UInt32 = UInt32(dataSize)
        
        let builder:MVitaPtpMessageOutBuilder = MVitaPtpMessageOutBuilder()
        builder.append(value:MVitaPtpType.dataPacket)
        builder.appendTransactionId()
        builder.append(data:packetData)
        
        data = builder.export()
    }
}
