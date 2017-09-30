import Foundation

extension MVitaLink
{
    private static let kLookItemPredicate:String = "name == \"%@\""
    private static let kLookItemSorter:String = "dateReceived"
    
    //MARK: internal
    
    func factoryPredicateFor(
        itemStatus:MVitaItemStatus) -> NSPredicate
    {
        let identifier:String = String(
            describing:itemStatus.identifier)
        let predicateString:String = String(
            format:MVitaLink.kLookItemPredicate,
            identifier)
        let predicate:NSPredicate = NSPredicate(
            format:predicateString)
        
        return predicate
    }
    
    func factorySortersForRecent() -> [NSSortDescriptor]
    {
        let sorter:NSSortDescriptor = NSSortDescriptor(
            key:MVitaLink.kLookItemSorter,
            ascending:false)
        let sorters:[NSSortDescriptor] = [
            sorter]
        
        return sorters
    }
}
