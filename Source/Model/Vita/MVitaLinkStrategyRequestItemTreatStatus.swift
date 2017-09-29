import Foundation

extension MVitaLinkStrategyRequestItemTreat
{
    //MARK: private
    
    private func requestItem(
        rawElement:UInt32)
    {
        guard
            
            let parentTreat:MVitaItemTreat = currentItem?.treat
            
        else
        {
            return
        }
        
        let itemTreat:MVitaItemTreat = MVitaItemTreat.factoryTreat(
            parentTreat:parentTreat,
            treatId:rawElement)
        
        requestItemFormat(itemTreat:itemTreat)
    }
    
    private func createNewItem(
        itemTreat:MVitaItemTreat)
    {
        let newItem:MVitaItemIn = MVitaItemIn(
            treat:itemTreat,
            parent:currentItem)
        currentItem?.addElement(element:newItem)
        currentItem = newItem
        
        if rootItemIn == nil
        {
            rootItemIn = currentItem
        }
    }
    
    private func nextElement()
    {
        guard
            
            let rawElement:UInt32 = currentItem?.rawElements?.popLast()
            
        else
        {
            currentItemFinished()
            
            return
        }
        
        requestItem(rawElement:rawElement)
    }
    
    private func currentItemFinished()
    {
        guard
            
            let parent:MVitaItemIn = currentItem?.parent
            
        else
        {
            allItemsFinished()
            
            return
        }
        
        currentItem = parent
        nextElement()
    }
    
    private func allItemsFinished()
    {
        resportResult()
    }
    
    //MARK: internal
    
    func requestItemFormat(
        itemTreat:MVitaItemTreat)
    {
        createNewItem(itemTreat:itemTreat)
        
        changeStatus(
            statusType:MVitaLinkStrategyRequestItemTreatFormat.self)
        model?.linkCommand.requestItemFormat(
            itemTreat:itemTreat)
    }
    
    func requestFileName(
        itemFormat:MVitaItemFormat)
    {
        guard
            
            let itemTreat:MVitaItemTreat = currentItem?.treat
            
        else
        {
            failed()
            
            return
        }
        
        currentItem?.format = itemFormat
        
        changeStatus(
            statusType:MVitaLinkStrategyRequestItemTreatName.self)
        model?.linkCommand.requestItemFileName(
            itemTreat:itemTreat)
    }
    
    func requestDateModified(
        itemFileName:String)
    {
        guard
            
            let itemTreat:MVitaItemTreat = currentItem?.treat
            
        else
        {
            failed()
            
            return
        }
        
        currentItem?.name = itemFileName
        
        changeStatus(
            statusType:MVitaLinkStrategyRequestItemTreatDateModified.self)
        model?.linkCommand.requestItemDateModified(
            itemTreat:itemTreat)
    }
    
    func requestItemContent(
        itemDateModified:Date)
    {
        currentItem?.dateModified = itemDateModified
        
        guard
            
            let itemFormat:MVitaItemFormat = currentItem?.format
            
        else
        {
            failed()
            
            return
        }
        
        requestItemContent(itemFormat:itemFormat)
    }
    
    func requestItemData(
        itemSize:UInt64)
    {
        guard
            
            let itemTreat:MVitaItemTreat = currentItem?.treat
            
        else
        {
            failed()
            
            return
        }
        
        currentItem?.size = itemSize
        
        changeStatus(
            statusType:MVitaLinkStrategyRequestItemTreatData.self)
        model?.linkCommand.requestItemData(
            itemTreat:itemTreat)
    }
    
    func itemElementsReceived(
        itemElements:[UInt32])
    {
        currentItem?.rawElements = itemElements
        nextElement()
    }
    
    func itemDataReceived(
        itemData:Data)
    {
        currentItem?.data = itemData
        nextElement()
    }
}
