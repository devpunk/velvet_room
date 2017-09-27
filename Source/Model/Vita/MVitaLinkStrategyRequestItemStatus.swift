import Foundation

final class MVitaLinkStrategyRequestItemStatus:
    MVitaLinkStrategyRequestData,
    MVitaLinkStrategyEventProtocol
{
    private var event:MVitaPtpMessageInEvent?
    
    override func failed()
    {
        let message:String = String.localizedModel(
            key:"MVitaLinkStrategyRequestItemStatus_messageFailed")
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

