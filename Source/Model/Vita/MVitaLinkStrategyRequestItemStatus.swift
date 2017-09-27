import Foundation

final class MVitaLinkStrategyRequestItemStatus:MVitaLinkStrategyRequestDataEvent
{
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
        
        requestItemStatus(itemStatus:itemStatus)
    }
    
    //MARK: private
    
    func requestItemStatus(
        itemStatus:MVitaItemStatus)
    {
        guard
        
            let event:MVitaPtpMessageInEvent = self.event
        
        else
        {
            failed()
            
            return
        }
        
        model?.requestItemStatus(
            itemStatus:itemStatus,
            event:event)
    }
}
