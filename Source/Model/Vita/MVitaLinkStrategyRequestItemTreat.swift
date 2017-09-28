import Foundation

final class MVitaLinkStrategyRequestItemTreat:MVitaLinkStrategyRequestDataEvent
{
    private(set) var itemTreat:MVitaItemTreat?
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
        model?.delegate?.vitaLinkError(message:message)
    }
    
    override func success()
    {
        status?.success(strategy:self)
    }
    
    //MARK: private

    private func changeStatus(
        statusType:MVitaLinkStrategyRequestItemTreatProtocol.Type)
    {
        let status:MVitaLinkStrategyRequestItemTreatProtocol = statusType.init()
        self.status = status
    }
    
    //MARK: internal
    
    func requestItemFormat(
        itemTreat:MVitaItemTreat)
    {
        self.itemTreat = itemTreat
        
        changeStatus(
            statusType:MVitaLinkStrategyRequestItemTreatFormat.self)
        
        guard
        
            let event:MVitaPtpMessageInEvent = self.event
        
        else
        {
            failed()
            
            return
        }
        
        model?.linkCommand.requestItemFormat(
            event:event)
    }
}
