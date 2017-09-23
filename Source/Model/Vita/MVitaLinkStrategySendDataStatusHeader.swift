import Foundation

final class MVitaLinkStrategySendDataStatusHeader:MVitaLinkStrategySendDataStatusProtocol
{
    init() { }
    
    func commandWrite(strategy:MVitaLinkStrategySendData)
    {
        strategy.packetStart()
    }
}
