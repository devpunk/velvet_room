import Foundation

extension MVitaLinkStrategyRequestItemTreat
{
    //MARK: internal

    func createElement(
        parent:MVitaItemInDirectory,
        treatId:UInt32)
    {
        let element:MVitaItemInElement = MVitaItemInElement(
            parent:parent,
            treatId:treatId)
        parent.elements.append(element)
        currentItem = element
        
        requestItemFormat(treatId:treatId)
    }
    
    func requestItemFileSize(
        treatId:UInt32)
    {
        changeStatus(
            statusType:MVitaLinkStrategyRequestItemTreatSize.self)
        model?.linkCommand.requestItemFileSize(
            treatId:treatId)
    }
    
    func requestItemData(
        itemSize:UInt64)
    {
        guard
            
            let currentItem:MVitaItemInElement = self.currentItem as? MVitaItemInElement
            
        else
        {
            failed()
            
            return
        }
        
        currentItem.size = itemSize
        
        changeStatus(
            statusType:MVitaLinkStrategyRequestItemTreatData.self)
        model?.linkCommand.requestItemData(
            treatId:currentItem.treatId)
    }
    func itemDataReceived(
        itemData:Data)
    {
        guard
            
            let currentItem:MVitaItemInElement = self.currentItem as? MVitaItemInElement
            
        else
        {
            failed()
            
            return
        }
        
        currentItem.data = data
        requestFinished()
    }
}
