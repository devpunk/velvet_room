import Foundation

extension MVitaLink
{
    private static let kLookItemPredicate:String = "identifier == \"%@\""
    private static let kLookIdentifierSorter:String = "created"
    
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
    
    func factorySortersForIdentifier() -> [NSSortDescriptor]
    {
        let sorter:NSSortDescriptor = NSSortDescriptor(
            key:MVitaLink.kLookIdentifierSorter,
            ascending:true)
        let sorters:[NSSortDescriptor] = [
            sorter]
        
        return sorters
    }
}
