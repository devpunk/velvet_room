import Foundation

final class MVitaLinkStrategySendItemConfirm:MVitaLinkStrategySendItemProtocol
{
    func nextStep(strategy:MVitaLinkStrategySendItem)
    {
        strategy.model?.listenEvents()
    }
}
