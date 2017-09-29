import Foundation

final class MVitaLinkStrategyRequestItemTreat:MVitaLinkStrategyRequestDataEvent
{
    weak var currentItem:MVitaItemIn?
    var rootItemIn:MVitaItemIn?
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
    
    //MARK: private
    
    private func requestItemElements()
    {
        guard
            
            let itemTreat:MVitaItemTreat = currentItem?.treat
            
        else
        {
            failed()
            
            return
        }
        
        changeStatus(
            statusType:MVitaLinkStrategyRequestItemTreatElements.self)
        model?.linkCommand.requestItemElements(
            itemTreat:itemTreat)
    }
    
    private func requestItemFileSize()
    {
        guard
            
            let itemTreat:MVitaItemTreat = currentItem?.treat
            
        else
        {
            failed()
            
            return
        }
        
        changeStatus(
            statusType:MVitaLinkStrategyRequestItemTreatSize.self)
        model?.linkCommand.requestItemFileSize(
            itemTreat:itemTreat)
    }
    
    //MARK: internal
    
    func changeStatus(
        statusType:MVitaLinkStrategyRequestItemTreatProtocol.Type)
    {
        restart()
        
        let status:MVitaLinkStrategyRequestItemTreatProtocol = statusType.init()
        self.status = status
    }
    
    func requestItemContent(
        itemFormat:MVitaItemFormat)
    {
        switch itemFormat
        {
        case MVitaItemFormat.folder:
            
            requestItemElements()
            
            break
            
        case MVitaItemFormat.file,
             MVitaItemFormat.unknown:
            
            requestItemFileSize()
            
            break
        }
    }
    
    func resportResult()
    {
        guard
        
            let event:MVitaPtpMessageInEvent = self.event,
            let vitaItem:MVitaItemIn = rootItemIn
        
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
