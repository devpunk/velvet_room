import Foundation

final class MVitaLinkStrategySendDataStatusPacket:MVitaLinkStrategySendDataStatusProtocol
{
    func commandWrite(strategy:MVitaLinkStrategySendData)
    {
        strategy.packet()
    }
}
