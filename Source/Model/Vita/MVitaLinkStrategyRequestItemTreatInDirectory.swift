import Foundation

extension MVitaLinkStrategyRequestItemTreat
{
    //MARK: internal
    
    func requestItemFormat(
        itemTreat:MVitaItemTreat)
    {
        let directory:MVitaItemInDirectory = MVitaItemInDirectory(
            itemTreat:itemTreat)
        rootItem = directory
        currentItem = directory
        
        requestItemFormat(
            treatId:directory.treatId)
    }
    
    func requestItemFormat(
        treatId:UInt32)
    {
        changeStatus(
            statusType:MVitaLinkStrategyRequestItemTreatFormat.self)
        model?.linkCommand.requestItemFormat(
            treatId:treatId)
    }
    
    func requestItemElements(treatId:UInt32)
    {
        changeStatus(
            statusType:MVitaLinkStrategyRequestItemTreatElements.self)
        model?.linkCommand.requestItemElements(
            treatId:treatId)
    }
    
    func itemElementsReceived(
        itemElements:[UInt32])
    {
        guard
            
            let currentItem:MVitaItemInDirectory = self.currentItem as? MVitaItemInDirectory
            
        else
        {
            failed()
            
            return
        }
        
        currentItem.rawElements.append(
            contentsOf:itemElements)
        requestFinished()
    }
}
