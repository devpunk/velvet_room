import Foundation

extension MVitaLinkStrategyRequestItemTreat
{
    //MARK: internal
    
    func requestFileName(
        itemFormat:MVitaItemFormat)
    {
        guard
            
            currentItem?.format == itemFormat,
            let treatId:UInt32 = currentItem?.treatId
            
        else
        {
            failed()
            
            return
        }
        
        changeStatus(
            statusType:MVitaLinkStrategyRequestItemTreatName.self)
        model?.linkCommand.requestItemFileName(
            treatId:treatId)
    }
    
    func requestDateModified(
        itemFileName:String)
    {
        guard
            
            let treatId:UInt32 = currentItem?.treatId
            
        else
        {
            failed()
            
            return
        }
        
        currentItem?.name = itemFileName
        
        changeStatus(
            statusType:MVitaLinkStrategyRequestItemTreatDateModified.self)
        model?.linkCommand.requestItemDateModified(
            treatId:treatId)
    }
    
    func requestItemContent(
        itemDateModified:Date)
    {
        currentItem?.dateModified = itemDateModified
        currentItem?.requestContent(strategy:self)
    }
    
    func requestFinished()
    {
        guard
        
            let rootItem:MVitaItemInDirectory = self.rootItem,
            let rawElement:UInt32 = rootItem.rawElements.popLast()
        
        else
        {
            resportResult()
            
            return
        }
        
        createElement(
            parent:rootItem,
            treatId:rawElement)
    }
}
