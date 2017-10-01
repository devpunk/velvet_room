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
        
        let directoryPath:URL = createDirectory(
            directoryName:vitaItem.localName)
        storeThumbnail(
            directoryPath:directoryPath,
            directory:vitaItem)
        
        database.create
        { (directory:DVitaItemDirectory) in
                
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
            
            let data:Data = vitaItem.data,
            let localName:String = storeRandomAtPath(
                data:data,
                directoryPath:directoryPath),
            let elementName:String = vitaItem.name,
            let dateCreated:Date = vitaItem.dateCreated,
            let dateModified:Date = vitaItem.dateModified
        
        else
        {
            return
        }
        
        dispatchGroup.enter()
        
        database.create
        { (element:DVitaItemElement) in
            
            element.create(
                name:elementName,
                localName:localName,
                dateCreated:dateCreated,
                dateModified:dateModified,
                size:vitaItem.size,
                fileExtension:vitaItem.fileExtension,
                directory:directory)
            
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
