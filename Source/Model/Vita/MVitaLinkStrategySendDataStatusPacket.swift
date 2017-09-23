import Foundation

final class MVitaLinkStrategySendDataStatusPacket:MVitaLinkStrategySendDataStatusProtocol
{
    init() { }
    
    func commandWrite(strategy:MVitaLinkStrategySendData)
    {
        strategy.packet()
    }
}
