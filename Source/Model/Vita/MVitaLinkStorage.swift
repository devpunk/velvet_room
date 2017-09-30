import Foundation

extension MVitaLink
{
    //MARK: private
    
    private class func asyncStoreItem(
        vitaItem:MVitaItemInDirectory,
        database:Database,
        completion:@escaping((DVitaItemDirectory) -> ()))
    {
        let directoryLocalName:String = UUID().uuidString
        
        guard
            
            let name:String = vitaItem.name,
            let dateModified:Date = vitaItem.dateModified
        
        else
        {
            return
        }
        
        createDirectory(
            name:name,
            localName:directoryLocalName,
            dateModified:dateModified,
            vitaItem:vitaItem,
            database:database,
            completion:completion)
    }
    
    private class func createDirectory(
        name:String,
        localName:String,
        dateModified:Date,
        vitaItem:MVitaItemInDirectory,
        database:Database,
        completion:@escaping((DVitaItemDirectory) -> ()))
    {
        let directoryPath:URL = createDirectory(
            directoryName:localName)
        storeThumbnail(
            directoryPath:directoryPath,
            directory:vitaItem)
        
        database.create
        { (directory:DVitaItemDirectory) in
            
            directory.create(
                name:name,
                localName:localName,
                dateModified:dateModified,
                category:vitaItem.category,
                directoryType:vitaItem.directoryType)
            
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
            let dateModified:Date = vitaItem.dateModified,
            let size:UInt64 = vitaItem.size
        
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
                dateModified:dateModified,
                size:size,
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
