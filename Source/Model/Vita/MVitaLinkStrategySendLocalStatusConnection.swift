import Foundation

final class MVitaLinkStrategySendLocalStatusConnection:MVitaLinkStrategySendLocalStatus
{
    override func failed()
    {
        let message:String = String.localizedModel(
            key:"MVitaLinkStrategySendLocalStatusConnection_messageFailed")
        model?.errorCloseConnection(
            message:message)
    }
    
    override func success()
    {
        model?.listenEvents()
    }
}
