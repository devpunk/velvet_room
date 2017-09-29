import Foundation

extension MVitaLink
{
    private static let kRootDirectory:String = "storage"
    
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
            
            guard
                
                let elements:[MVitaItemIn] = vitaItem.elements
            
            else
            {
                self?.storeCompleted(
                    database:database,
                    completion:completion)
                
                return
            }
            
            self?.storeElements(
                elements:elements,
                directory:directory,
                database:database,
                completion:completion)
        }
    }
    
    private func storeElements(
        elements:[MVitaItemIn],
        directory:DVitaItemDirectory,
        database:Database,
        completion:@escaping(() -> ()))
    {
        let dispatchGroup:DispatchGroup = MVitaLink.factoryDispatchGroup()
        
        for element:MVitaItemIn in elements
        {
            storeElement(
                element:element,
                directory:directory,
                database:database,
                dispatchGroup:dispatchGroup)
        }
        
        dispatchGroup.notify(
            queue:DispatchQueue.global(
                qos:DispatchQoS.QoSClass.background))
        { [weak self] in
            
            self?.storeCompleted(
                database:database,
                completion:completion)
        }
    }
    
    private func storeElement(
        element:MVitaItemIn,
        directory:DVitaItemDirectory,
        database:Database,
        dispatchGroup:DispatchGroup)
    {
        guard
            
            let data:Data = element.data,
            let directoryName:String = directory.name,
            let localName:String = storeLocal(
                data:data,
                directoryName:directoryName),
            let name:String = element.name,
            let dateModified:Date = element.dateModified,
            let size:UInt64 = element.size
        
        else
        {
            return
        }
        
        dispatchGroup.enter()
        
        database.create
        { (storedElement:DVitaItemElement) in
            
            storedElement.create(
                name:name,
                localName:localName,
                dateModified:dateModified,
                size:size,
                directory:directory)
            
            print("stored: \(name) at: \(localName)")
            
            dispatchGroup.leave()
        }
    }
    
    private func storeLocal(
        data:Data,
        directoryName:String) -> String?
    {
        let randomName:String = UUID().uuidString
        
        var elementPath:URL = FileManager.default.appDirectory
        elementPath.appendPathComponent(
            MVitaLink.kRootDirectory)
        elementPath.appendPathComponent(
            directoryName)
        elementPath.appendPathComponent(randomName)
        elementPath.excludeFromBackup()
        
        do
        {
            try data.write(
                to:elementPath,
                options:
                Data.WritingOptions.atomicWrite)
        }
        catch
        {
            return nil
        }
        
        print("path: \(elementPath)")
        
        return randomName
    }
    
    private func storeCompleted(
        database:Database,
        completion:@escaping(() -> ()))
    {
        database.save(completion:completion)
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
