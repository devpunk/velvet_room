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
    
    func requestDateCreated(
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
            statusType:MVitaLinkStrategyRequestItemTreatDateCreated.self)
        model?.linkCommand.requestItemDateCreated(
            treatId:treatId)
    }
    
    func requestDateModified(
        itemDateCreated:Date)
    {
        guard
            
            let treatId:UInt32 = currentItem?.treatId
            
        else
        {
            failed()
            
            return
        }
        
        currentItem?.dateCreated = itemDateCreated
        
        changeStatus(
            statusType:MVitaLinkStrategyRequestItemTreatDateModified.self)
        model?.linkCommand.requestItemDateModified(
            treatId:treatId)
    }
    
    func requestItemSize(
        itemDateModified:Date)
    {
        guard
            
            let treatId:UInt32 = currentItem?.treatId
            
        else
        {
            failed()
            
            return
        }
        
        currentItem?.dateModified = itemDateModified
        
        changeStatus(
            statusType:MVitaLinkStrategyRequestItemTreatSize.self)
        model?.linkCommand.requestItemFileSize(
            treatId:treatId)
    }
    
    func requestItemContent(
        itemSize:UInt64)
    {
        currentItem?.size = itemSize
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
