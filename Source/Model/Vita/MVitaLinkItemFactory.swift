import Foundation

extension MVitaLink
{
    private static let kLookItemPredicate:String = "identifier == \"%@\""
    
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
}
