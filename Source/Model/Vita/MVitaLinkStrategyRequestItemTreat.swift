import Foundation

final class MVitaLinkStrategyRequestItemTreat:
    MVitaLinkStrategyRequestData,
    MVitaLinkStrategyEventProtocol
{
    private var event:MVitaPtpMessageInEvent?
    
    override func failed()
    {
        let message:String = String.localizedModel(
            key:"MVitaLinkStrategyRequestItemTreat_messageFailed")
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
    
    //MARK: event protocol
    
    func config(event:MVitaPtpMessageInEvent)
    {
        self.event = event
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
