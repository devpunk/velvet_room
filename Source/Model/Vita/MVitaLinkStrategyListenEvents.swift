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
                data:data),
            header.type == MVitaPtpType.event
        
        else
        {
            failed()
            
            return
        }
        
        success(message:message)
    }
    
    //MARK: private
    
    private func failed()
    {
        let message:String = String.localizedModel(
            key:"MVitaLinkStrategyListenEvents_messageFailed")
        model?.delegate?.linkError(message:message)
    }
    
    private func success(message:MVitaPtpMessageInEvent)
    {
        model?.receivedEvent(
            event:message)
    }
}
