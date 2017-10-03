import Foundation

extension MVitaLink
{
    //MARK: private
    
    private class func asyncStoreItem(
        vitaItem:MVitaItemInDirectory,
        database:Database,
        completion:@escaping((DVitaItemDirectory) -> ()))
    {
        vitaItem.parse()
        
        guard
            
            let directoryName:String = vitaItem.name
        
        else
        {
            return
        }
        
        factoryIdentifier(
            identifier:directoryName,
            database:database)
        { (identifier:DVitaIdentifier) in
         
            storeItem(
                vitaItem:vitaItem,
                identifier:identifier,
                database:database,
                completion:completion)
        }
    }
    
    private class func storeItem(
        vitaItem:MVitaItemInDirectory,
        identifier:DVitaIdentifier,
        database:Database,
        completion:@escaping((DVitaItemDirectory) -> ()))
    {
        let directoryPath:URL = createDirectory(
            directoryName:vitaItem.localName)
        
        database.create
        { (directory:DVitaItemDirectory) in
            
            directory.identifier = identifier
            directory.config(
                itemDirectory:vitaItem)
            
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
        completion:@escaping((DVitaItemDirectory) -> ()))
    {
        let dispatchGroup:DispatchGroup = MVitaLink.factoryDispatchGroup()
        
        for element:MVitaItemInElement in elements
        {
            createElement(
                vitaItem:element,
                directory:directory,
                directoryPath:directoryPath,
                database:database,
                dispatchGroup:dispatchGroup)
        }
        
        dispatchGroup.notify(
            queue:DispatchQueue.global(
                qos:DispatchQoS.QoSClass.background))
        {
            database.save
            {
                completion(directory)
            }
        }
    }
    
    private class func createElement(
        vitaItem:MVitaItemInElement,
        directory:DVitaItemDirectory,
        directoryPath:URL,
        database:Database,
        dispatchGroup:DispatchGroup)
    {
        guard
        
            let data:Data = vitaItem.data
        
        else
        {
            return
        }
        
        do
        {
            try storeElement(
                localName:vitaItem.localName,
                directoryPath:directoryPath,
                data:data)
        }
        catch
        {
            return
        }
        
        dispatchGroup.enter()
        
        database.create
        { (element:DVitaItemElement) in
            
            element.directory = directory
            element.config(
                itemElement:vitaItem)
            
            dispatchGroup.leave()
        }
    }
    
    //MARK: internal
    
    class func storeItem(
        vitaItem:MVitaItemInDirectory,
        database:Database,
        completion:@escaping((DVitaItemDirectory) -> ()))
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
