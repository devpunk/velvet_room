import Foundation

final class MVitaLinkStrategySendItemElementData:MVitaLinkStrategySendItemProtocol
{
    func nextStep(strategy:MVitaLinkStrategySendItem)
    {
        strategy.lastElementInfo()
    }
}
