import Foundation

struct MVitaPtpMessageOutPacketEnd:MVitaPtpMessageOutProtocol
{
    let data:Data
    
    init(packetData:Data)
    {
        let builder:MVitaPtpMessageOutBuilder = MVitaPtpMessageOutBuilder()
        builder.append(value:MVitaPtpType.dataPacketEnd)
        let tran:UInt32 = 5
        builder.append(value:tran)
        builder.append(data:packetData)
        
        data = builder.export()
        
        print("data in message \(data.count)")
    }
}
