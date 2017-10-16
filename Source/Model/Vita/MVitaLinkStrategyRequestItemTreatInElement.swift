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
    
    func requestItemData(
        treatId:UInt32)
    {
        changeStatus(
            statusType:MVitaLinkStrategyRequestItemTreatData.self)
        model?.linkCommand.requestItemData(
            treatId:treatId)
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
        
        let updatedSize:UInt64 = UInt64(data.count)
        
        currentItem.data = data
        currentItem.size = updatedSize
        requestFinished()
    }
}
