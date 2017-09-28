import Foundation

final class MVitaLinkStrategySendLocalStatusConnectionEndError:
    MVitaLinkStrategySendLocalStatusConnectionEnd
{
    override func failed()
    {
        model?.closeSessionError()
    }
    
    override func success()
    {
        model?.closeSessionError()
    }
}
