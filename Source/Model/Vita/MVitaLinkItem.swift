import Foundation

extension MVitaLink
{
    //MARK: private
    
    private func sendItemsMetadata(
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
    
    private func fetchWithPredicate(
        predicate:NSPredicate,
        database:Database,
        event:MVitaPtpMessageInEvent)
    {
        database.fetch(
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
            
            self?.sendItemsMetadata(
                items:items,
                event:event)
        }
    }
    
    private func fetchWithLimit(
        limit:Int,
        database:Database,
        event:MVitaPtpMessageInEvent)
    {
        database.fetch(
            limit:limit)
        { [weak self] (identifiers:[DVitaIdentifier]) in
            
            var items:[DVitaItemDirectory] = []
            
            for identifier:DVitaIdentifier in identifiers
            {
                guard
                    
                    let lastDirectory:DVitaItemDirectory = identifier.items?.array.last as? DVitaItemDirectory
                    
                else
                {
                    continue
                }
                
                items.append(lastDirectory)
            }
            
            print("sending \(items.count)")
            
            self?.sendItemsMetadata(
                items:items,
                event:event)
        }
    }
    
    //MARK: internal
    
    func requestItemStatus(
        itemStatus:MVitaItemStatus,
        event:MVitaPtpMessageInEvent)
    {
        guard
            
            let database:Database = self.database
        
        else
        {
            itemNotFound(event:event)
            
            return
        }
        
        let predicate:NSPredicate = factoryPredicateFor(
            itemStatus:itemStatus)
        
        fetchWithPredicate(
            predicate:predicate,
            database:database,
            event:event)
    }
    
    func sendItemsMetadata(
        category:MVitaItemCategory,
        count:Int,
        event:MVitaPtpMessageInEvent)
    {
        guard
        
            category == MVitaItemCategory.savedData,
            count > 0,
            let database:Database = self.database
        
        else
        {
            sendItemsMetadata(
                items:[],
                event:event)
            
            return
        }
        
        fetchWithLimit(
            limit:count,
            database:database,
            event:event)
    }
}
