import Foundation

final class MVitaLinkStrategySendItemElementInfo:MVitaLinkStrategySendItemProtocol
{
    func nextStep(strategy:MVitaLinkStrategySendItem)
    {
        strategy.lastElementDataAndPop()
    }
}
