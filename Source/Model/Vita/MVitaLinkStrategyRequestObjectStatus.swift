import Foundation

final class MVitaLinkStrategyRequestObjectStatus:
    MVitaLinkStrategyRequestData,
    MVitaLinkStrategyEventProtocol
{
    private var event:MVitaPtpMessageInEvent?
    
    override func failed()
    {
        let message:String = String.localizedModel(
            key:"MVitaLinkStrategyRequestObjectStatus_messageFailed")
        model?.delegate?.vitaLinkError(message:message)
    }
    
    override func success()
    {
    }
    
    //MARK: event protocol
    
    func config(event:MVitaPtpMessageInEvent)
    {
        self.event = event
    }
    
    //MARK: private
}
