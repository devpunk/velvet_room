import Foundation

final class MVitaLinkStrategySendItemDirectoryInfo:MVitaLinkStrategySendItemProtocol
{
    func nextStep(strategy:MVitaLinkStrategySendItem)
    {
        strategy.lastElementInfo()
    }
}
