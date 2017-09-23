import Foundation

final class MVitaLinkStrategySendDataStatusConfirm:MVitaLinkStrategySendDataStatusProtocol
{
    init() { }
    
    func commandWrite(strategy:MVitaLinkStrategySendData)
    {
        strategy.packet()
    }
}
