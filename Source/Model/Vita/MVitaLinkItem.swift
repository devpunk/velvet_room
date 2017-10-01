import Foundation

extension MVitaLink
{
    //MARK: private
    
    private func itemFound(
        item:DVitaItemDirectory,
        event:MVitaPtpMessageInEvent)
    {
        changeStrategy(strategyType:
            MVitaLinkStrategySendItemMetadata.self)
        strategyItem(item:item)
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
            
            self?.itemFound(
                item:lastDirectory,
                event:event)
        }
    }
    
    func sendItemsMetaData(
        category:MVitaItemCategory,
        count:Int,
        event:MVitaPtpMessageInEvent)
    {
        
    }
}
