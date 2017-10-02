import Foundation

extension MVitaLink
{
    //MARK: private
    
    private func sendItemsMetaData(
        items:[DVitaItemDirectory],
        event:MVitaPtpMessageInEvent)
    {
        changeStrategy(strategyType:
            MVitaLinkStrategySendItemMetadata.self)
        strategyItems(items:items)
        strategyEvent(event:event)
    }
    
    private func itemNotFound(
        event:MVitaPtpMessageInEvent)
    {
        sendResultSuccess(event:event)
    }
    
    //MARK: internal
    
    func requestItemStatus(
        itemStatus:MVitaItemStatus,
        event:MVitaPtpMessageInEvent)
    {
        let predicate:NSPredicate = factoryPredicateFor(
            itemStatus:itemStatus)
        
        database?.fetch(
            predicate:predicate)
        { [weak self] (identifiers:[DVitaIdentifier]) in
            
            guard
            
                let identifier:DVitaIdentifier = identifiers.first,
                let lastDirectory:DVitaItemDirectory = identifier.items?.array.last as? DVitaItemDirectory
            
            else
            {
                self?.itemNotFound(event:event)
                
                return
            }
            
            let items:[DVitaItemDirectory] = [
                lastDirectory]
            
            self?.sendItemsMetaData(
                items:items,
                event:event)
        }
    }
    
    func sendItemsMetaData(
        category:MVitaItemCategory,
        count:Int,
        event:MVitaPtpMessageInEvent)
    {
        sendItemsMetaData(
            items:[],
            event:event)
    }
}
