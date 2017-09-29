import Foundation

extension MVitaLink
{
    //MARK: private
    
    private class func factoryDispatchGroup() -> DispatchGroup
    {
        let dispatchGroup:DispatchGroup = DispatchGroup()
        dispatchGroup.setTarget(
            queue:DispatchQueue.global(
                qos:DispatchQoS.QoSClass.background))
        
        return dispatchGroup
    }
    
    private func asyncStoreItem(
        vitaItem:MVitaItemIn,
        database:Database,
        completion:@escaping(() -> ()))
    {
        database.create
        { [weak self] (directory:DVitaItemDirectory) in
            
            
        }
    }
    
    private func storeElements(
        vitaItem:MVitaItemIn,
        database:Database,
        completion:@escaping(() -> ()))
    {
        let dispatchGroup:DispatchGroup = MVitaLink.factoryDispatchGroup()
        
        dispatchGroup.notify(
            queue:DispatchQueue.global(
                qos:DispatchQoS.QoSClass.background))
        {
            database.save(completion:completion)
        }
    }
    
    //MARK: internal
    
    func storeItem(
        vitaItem:MVitaItemIn,
        database:Database,
        completion:@escaping(() -> ()))
    {
        DispatchQueue.global(
            qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncStoreItem(
                vitaItem:vitaItem,
                database:database,
                completion:completion)
        }
    }
}
