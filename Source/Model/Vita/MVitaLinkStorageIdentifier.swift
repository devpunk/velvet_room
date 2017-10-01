import Foundation

extension MVitaLink
{
    private static let kPredicate:String = "identifier == \"%@\""
    
    private class func factoryPredicate(
        identifier:String) -> NSPredicate
    {
        let predicateString:String = String(
            format:MVitaLink.kPredicate,
            identifier)
        let predicate:NSPredicate = NSPredicate(
            format:predicateString)
        
        return predicate
    }
    
    private class func createIdentifier(
        identifier:String,
        database:Database,
        completion:@escaping((DVitaIdentifier) -> ()))
    {
        database.create
        { (item:DVitaIdentifier) in
            
            item.identifier = identifier
            
            identifierCreated(
                identifier:item,
                database:database,
                completion:completion)
        }
    }
    
    private class func identifierCreated(
        identifier:DVitaIdentifier,
        database:Database,
        completion:@escaping((DVitaIdentifier) -> ()))
    {
        database.save
        {
            completion(identifier)
        }
    }
    
    //MARK: internal
    
    class func factoryIdentifier(
        identifier:String,
        database:Database,
        completion:@escaping((DVitaIdentifier) -> ()))
    {
        let predicate:NSPredicate = factoryPredicate(
            identifier:identifier)
        
        database.fetch(predicate:predicate)
        { (items:[DVitaIdentifier]) in
            
            guard
            
                let first:DVitaIdentifier = items.first
            
            else
            {
                createIdentifier(
                    identifier:identifier,
                    database:database,
                    completion:completion)
                
                return
            }
            
            completion(first)
        }
    }
}
