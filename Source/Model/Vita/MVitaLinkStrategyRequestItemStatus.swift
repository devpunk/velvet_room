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
        guard
        
            let itemStatus:MVitaItemStatus = MVitaItemStatus.factoryStatus(
                data:data)
        
        else
        {
            failed()
            
            return
        }
        
        print("status: \(itemStatus.itemId) : \(itemStatus.name)")
    }
    
    //MARK: event protocol
    
    func config(event:MVitaPtpMessageInEvent)
    {
        self.event = event
    }
    
    //MARK: private
    
    
}
