import Foundation

final class MVitaLinkStrategySendDataStatusConfirm:MVitaLinkStrategySendDataStatusProtocol
{
    func commandWrite(strategy:MVitaLinkStrategySendData)
    {
        strategy.model?.linkCommand.readData()
    }
}
