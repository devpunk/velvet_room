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
        let sorters:[NSSortDescriptor] = factorySortersForRecent()
        
        database?.fetch(
            predicate:predicate,
            sorters:sorters)
        { [weak self] (directories:[DVitaItemDirectory]) in
            
            guard
            
                let directory:DVitaItemDirectory = directories.first
            
            else
            {
                self?.itemNotFound(event:event)
                
                return
            }
            
            self?.itemFound(
                item:directory,
                event:event)
        }
    }
}
