import Foundation

final class MVitaLinkStrategySendItemInvalid:MVitaLinkStrategySendItemProtocol
{
    func nextStep(strategy:MVitaLinkStrategySendItem)
    {
        strategy.model?.listenEvents()
    }
}