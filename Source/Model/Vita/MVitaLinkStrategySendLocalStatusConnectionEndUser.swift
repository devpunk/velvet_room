import Foundation

final class MVitaLinkStrategySendLocalStatusConnectionEndUser:
    MVitaLinkStrategySendLocalStatusConnectionEnd
{
    override func failed()
    {
        model?.closeSessionUser()
    }
    
    override func success()
    {
        model?.closeSessionUser()
    }
}
