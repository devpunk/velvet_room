import Foundation

final class MVitaLinkStrategySendLocalStatusConnectionEnd:MVitaLinkStrategySendLocalStatus
{
    override func failed()
    {
        print("failed connection end")
        model?.delegate?.vitaLinkConnectionClosed()
    }
    
    override func success()
    {
        print("success connection end")
        model?.delegate?.vitaLinkConnectionClosed()
    }
}
