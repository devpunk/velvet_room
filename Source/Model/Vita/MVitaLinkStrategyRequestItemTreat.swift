import Foundation

final class MVitaLinkStrategyRequestItemTreat:MVitaLinkStrategyRequestDataEvent
{
    private(set) var itemTreat:MVitaItemTreat?
    private(set) var itemFormat:MVitaItemFormat?
    private(set) var itemFileName:String?
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
        
        restart()
        changeStatus(
            statusType:MVitaLinkStrategyRequestItemTreatFormat.self)
        model?.linkCommand.requestItemFormat(
            itemTreat:itemTreat)
    }
    
    func requestFileName(
        itemFormat:MVitaItemFormat)
    {
        guard
            
            let itemTreat:MVitaItemTreat = self.itemTreat
        
        else
        {
            failed()
            
            return
        }
        
        self.itemFormat = itemFormat
        
        restart()
        changeStatus(
            statusType:MVitaLinkStrategyRequestItemTreatFileName.self)
        model?.linkCommand.requestItemFileName(
            itemTreat:itemTreat)
    }
    
    func requestDateModified(
        itemFileName:String)
    {
        guard
            
            let itemTreat:MVitaItemTreat = self.itemTreat
            
        else
        {
            failed()
            
            return
        }
        
        self.itemFileName = itemFileName
        
        restart()
        changeStatus(
            statusType:MVitaLinkStrategyRequestItemTreatDateModified.self)
        model?.linkCommand.requestItemDateModified(
            itemTreat:itemTreat)
    }
}
