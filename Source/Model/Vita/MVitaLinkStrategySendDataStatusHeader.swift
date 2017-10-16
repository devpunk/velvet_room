import Foundation

final class MVitaLinkStrategySendDataStatusHeader:MVitaLinkStrategySendDataStatusProtocol
{
    func commandWrite(strategy:MVitaLinkStrategySendData)
    {
        strategy.packetStart()
    }
}
