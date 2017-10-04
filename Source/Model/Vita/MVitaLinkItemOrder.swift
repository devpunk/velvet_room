import Foundation

extension MVitaLink
{
    //MARK: private
    
    private func directoryAtEventPosition(
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
    
    func directoryAtEventPosition(
        event:MVitaPtpMessageInEvent,
        completion:@escaping((DVitaItemDirectory?) -> ()))
    {
        guard
        
            let database:Database = self.database,
            let unsignedItemIndex:UInt32 = event.parameters.first
        
        else
        {
            completion(nil)
            
            return
        }
        
        let itemIndex:Int = Int(unsignedItemIndex)
        let sorters:[NSSortDescriptor] = MVitaLink.factorySortersForIdentifier()
        
        directoryAtEventPosition(
            database:database,
            itemIndex:itemIndex,
            sorters:sorters,
            completion:completion)
    }
}
