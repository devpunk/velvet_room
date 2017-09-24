import Foundation

final class MVitaLinkStrategySendLocalStatusConnectionEnd:MVitaLinkStrategySendLocalStatus
{
    override func failed()
    {
        model?.closeSession()
    }
    
    override func success()
    {
        model?.closeSession()
    }
}
