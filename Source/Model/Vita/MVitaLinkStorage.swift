import Foundation

extension MVitaLink
{
    //MARK: private
    
    private func asyncStoreItem(
        vitaItem:MVitaItemIn,
        database:Database,
        completion:@escaping(() -> ()))
    {
        guard
            
            let name:String = vitaItem.name
        
        else
        {
            return
        }
        
        database.create
        { [weak self] (directory:DVitaItemDirectory) in
            
            directory.create(
                category:vitaItem.treat.category,
                name:name)
            
            guard
                
                let directoryPath:URL = self?.createDirectoryPath(
                    name:name),
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
                directoryPath:directoryPath,
                database:database,
                completion:completion)
        }
    }
    
    private func createDirectoryPath(
        name:String) -> URL?
    {
        var directoryPath:URL = FileManager.default.appDirectory
        directoryPath.appendPathComponent(
            MVitaLink.kRootDirectory)
        directoryPath.excludeFromBackup()
        directoryPath.appendPathComponent(
            name)
        directoryPath.excludeFromBackup()
        
        do
        {
            try FileManager.default.createDirectory(
                at:directoryPath,
                withIntermediateDirectories:true,
                attributes:nil)
        }
        catch
        {
            return nil
        }
        
        return directoryPath
    }
    
    private func storeElements(
        elements:[MVitaItemIn],
        directory:DVitaItemDirectory,
        directoryPath:URL,
        database:Database,
        completion:@escaping(() -> ()))
    {
        let dispatchGroup:DispatchGroup = MVitaLink.factoryDispatchGroup()
        
        for element:MVitaItemIn in elements
        {
            storeElement(
                element:element,
                directory:directory,
                directoryPath:directoryPath,
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
        directoryPath:URL,
        database:Database,
        dispatchGroup:DispatchGroup)
    {
        guard
            
            let data:Data = element.data,
            let localName:String = storeLocal(
                data:data,
                directoryPath:directoryPath),
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
        directoryPath:URL) -> String?
    {
        let randomName:String = UUID().uuidString
        let elementPath:URL = directoryPath.appendingPathComponent(
            randomName)
        
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
