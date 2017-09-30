import Foundation

final class MVitaLinkStrategyRequestItemTreat:MVitaLinkStrategyRequestDataEvent
{
    weak var currentItem:MVitaItemIn?
    var rootItem:MVitaItemInDirectory?
    private var status:MVitaLinkStrategyRequestItemTreatProtocol?
    
    required init(model:MVitaLink)
    {
        super.init(model:model)
        
        changeStatus(
            statusType:MVitaLinkStrategyRequestItemTreatStart.self)
    }
    
    override func failed()
    {
        let message:String = String.localizedModel(
            key:"MVitaLinkStrategyRequestItemTreat_messageFailed")
        model?.errorCloseConnection(
            message:message)
    }
    
    override func success()
    {
        status?.success(strategy:self)
    }
    
    //MARK: internal
    
    func changeStatus(
        statusType:MVitaLinkStrategyRequestItemTreatProtocol.Type)
    {
        restart()
        
        let status:MVitaLinkStrategyRequestItemTreatProtocol = statusType.init()
        self.status = status
    }
    
    func resportResult()
    {
        guard
        
            let event:MVitaPtpMessageInEvent = self.event,
            let vitaItem:MVitaItemIn = rootItem
        
        else
        {
            failed()
            
            return
        }
        
        model?.sendResult(
            vitaItem:vitaItem,
            event:event)
    }
}
