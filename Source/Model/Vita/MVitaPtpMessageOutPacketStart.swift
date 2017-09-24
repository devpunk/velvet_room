import Foundation

struct MVitaPtpMessageOutPacketStart:MVitaPtpMessageOutProtocol
{
    let data:Data
    private let kStartingByte:UInt32 = 0
    
    init(dataSize:Int)
    {
        let dataSizeUnsigned:UInt32 = UInt32(dataSize)
        
        let builder:MVitaPtpMessageOutBuilder = MVitaPtpMessageOutBuilder()
        builder.append(value:MVitaPtpType.dataPacketStart.rawValue)
        builder.appendTransactionId()
        builder.append(value:dataSizeUnsigned)
        builder.append(value:kStartingByte)
        
        data = builder.export()
    }
}
