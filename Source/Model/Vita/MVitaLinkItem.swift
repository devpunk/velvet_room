import Foundation

extension MVitaLink
{
    private static let kLookItemPredicate:String = "name == \"%@\""
    private static let kLookItemSorter:String = "dateReceived"
    
    //MARK: private
    
    private func itemFound(
        item:DVitaItemDirectory,
        event:MVitaPtpMessageInEvent)
    {
        
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
        let predicate:NSPredicate = NSPredicate(
            format:MVitaLink.kLookItemPredicate,
            itemStatus.identifier)
        let sorter:NSSortDescriptor = NSSortDescriptor(
            key:MVitaLink.kLookItemSorter,
            ascending:false)
        let sorters:[NSSortDescriptor] = [
            sorter]
        
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
