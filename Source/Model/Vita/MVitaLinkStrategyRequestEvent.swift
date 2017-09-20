import Foundation

final class MVitaLinkStrategyRequestEvent:MVitaLinkStrategyProtocol
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
            
            let requestEvent:MVitaPtpMessageInRequestEvent = MVitaPtpMessageInRequestEvent(
                header:header,
                data:data),
            header.type == MVitaPtpType.eventRequestAccepted
            
        else
        {
            return
        }
        
        success(requestEvent:requestEvent)
    }
    
    //MARK: private
    
    private func failed()
    {
        let message:String = String.localizedModel(
            key:"MVitaLinkStrategyRequestEvent_messageFailed")
        model?.delegate?.linkError(message:message)
    }
    
    private func success(
        requestEvent:MVitaPtpMessageInRequestEvent)
    {
        
    }
}
