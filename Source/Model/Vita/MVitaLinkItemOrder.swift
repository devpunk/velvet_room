import Foundation

extension MVitaLink
{
    //MARK: private
    
    private func directoryAtPosition(
        database:Database,
        itemIndex:Int,
        sorters:[NSSortDescriptor],
        completion:@escaping((DVitaItemDirectory?) -> ()))
    {
        database.fetch(sorters:sorters)
        { (identifiers:[DVitaIdentifier]) in
            
            let totalIdentifiers:Int = identifiers.count
            
            guard
                
                totalIdentifiers > itemIndex
                
            else
            {
                completion(nil)
                
                return
            }
            
            let identifier:DVitaIdentifier = identifiers[itemIndex]
            let directory:DVitaItemDirectory? = identifier.items?.lastObject as? DVitaItemDirectory
            
            completion(directory)
        }
    }
    
    //MARK: internal
    
    func directoryAtPosition(
        itemIndex:Int,
        completion:@escaping((DVitaItemDirectory?) -> ()))
    {
        guard
        
            let database:Database = self.database
        
        else
        {
            completion(nil)
            
            return
        }
        
        let sorters:[NSSortDescriptor] = MVitaLink.factorySortersForIdentifier()
        
        directoryAtPosition(
            database:database,
            itemIndex:itemIndex,
            sorters:sorters,
            completion:completion)
    }
}
