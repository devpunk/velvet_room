import Foundation

extension MVitaLink
{
    //MARK: private
    
    private class func asyncStoreItem(
        vitaItem:MVitaItemInDirectory,
        database:Database,
        completion:@escaping(() -> ()))
    {
        vitaItem.findThumbnail()
        
        guard
            
            let name:String = vitaItem.name
        
        else
        {
            return
        }
        
        createDirectory(
            name:name,
            vitaItem:vitaItem,
            database:database,
            completion:completion)
    }
    
    private class func createDirectory(
        name:String,
        vitaItem:MVitaItemInDirectory,
        database:Database,
        completion:@escaping(() -> ()))
    {
        let directoryPath:URL = createDirectory(
            directoryName:name)
        
        database.create
        { (directory:DVitaItemDirectory) in
            
            directory.create(
                category:vitaItem.category,
                name:name)
            
            createElements(
                directory:directory,
                directoryPath:directoryPath,
                elements:vitaItem.elements,
                database:database,
                completion:completion)
        }
    }
    
    private class func createElements(
        directory:DVitaItemDirectory,
        directoryPath:URL,
        elements:[MVitaItemInElement],
        database:Database,
        completion:@escaping(() -> ()))
    {
        let dispatchGroup:DispatchGroup = MVitaLink.factoryDispatchGroup()
        
        for element:MVitaItemIn in elements
        {
            createElement(
                element:element,
                directory:directory,
                directoryPath:directoryPath,
                database:database,
                dispatchGroup:dispatchGroup)
        }
        
        dispatchGroup.notify(
            queue:DispatchQueue.global(
                qos:DispatchQoS.QoSClass.background))
        {
            database.save(completion:completion)
        }
    }
    
    private class func createElement(
        element:MVitaItemInElement,
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
            let elementName:String = element.name,
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
    
    private class func storeLocal(
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
    
    //MARK: internal
    
    class func storeItem(
        vitaItem:MVitaItemInDirectory,
        database:Database,
        completion:@escaping(() -> ()))
    {
        DispatchQueue.global(
            qos:DispatchQoS.QoSClass.background).async
        {
            asyncStoreItem(
                vitaItem:vitaItem,
                database:database,
                completion:completion)
        }
    }
}
