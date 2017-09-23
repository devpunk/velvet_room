import Foundation

final class MVitaLinkStrategySendDataStatusPacketStart:MVitaLinkStrategySendDataStatusProtocol
{
    init() { }
    
    func commandWrite(strategy:MVitaLinkStrategySendData)
    {
        strategy.packetStart()
    }
}
