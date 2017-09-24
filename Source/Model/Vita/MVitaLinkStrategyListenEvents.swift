import Foundation

final class MVitaLinkStrategyListenEvents:MVitaLinkStrategyProtocol
{
    private(set) var model:MVitaLink?
    
    init(model:MVitaLink)
    {
        self.model = model
    }
    
    //MARK: protocol
    
    func eventReceived(
        header:MVitaPtpMessageInHeader,
        data:Data)
    {
        guard
        
            let message:MVitaPtpMessageInEvent = MVitaPtpMessageInEvent(
                header:header,
                data:data)
        
        else
        {
            failed()
            
            return
        }
    }
    
    //MARK: private
    
    private func failed()
    {
        let message:String = String.localizedModel(
            key:"MVitaLinkStrategySendLocalStatus_messageFailed")
        model?.delegate?.linkError(message:message)
    }
    
    private func success()
    {
        model?.listenEvents()
    }
}
