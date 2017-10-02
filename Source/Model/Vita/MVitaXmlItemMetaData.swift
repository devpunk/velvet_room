import Foundation
import XmlHero

final class MVitaXmlItemMetaData
{
    private static let kKeyRoot:String = "objectMetadata"
    private static let kKeyFolder:String = "folder"
    private static let kKeyFile:String = "file"
    private static let kKeyIndex:String = "index"
    
    //MARK: private
    
    private init() { }
    
    private class func factoryItems(
        item:DVitaItem,
        index:Int) -> [[String:Any]]
    {
        guard
        
            let directory:DVitaItemDirectory = item as? DVitaItemDirectory
        
        else
        {
            guard
            
                let element:DVitaItemElement = item as? DVitaItemElement
            
            else
            {
                return []
            }
            
            let heasheable:[String:Any] = factoryFileItem(
                item:element,
                index:index)
            let items:[[String:Any]] = [
                heasheable]
            
            return items
        }
        
        let items:[[String:Any]] = factoryItemsDirectory(
            item:directory,
            index:index)
        
        return items
    }
    
    private class func factoryItemsDirectory(
        item:DVitaItemDirectory,
        index:Int) -> [[String:Any]]
    {
        let folderItem:[String:Any] = factoryFolderItem(
            item:item,
            index:index)
        
        var items:[[String:Any]] = [
            folderItem]
        let newIndex:Int = index + 1
        
        guard
            
            let elements:[DVitaItemElement] = item.elements?.array as? [DVitaItemElement]
            
        else
        {
            return items
        }
        
        let hashElements:[[String:Any]] = factoryElements(
            elements:elements,
            index:newIndex)
        
//        items.append(contentsOf:hashElements)
        
        return items
    }
    
    private class func factoryFolderItem(
        item:DVitaItemDirectory,
        index:Int) -> [String:Any]
    {
        var hasheableItem:[String:Any] = item.hasheableItem
        hasheableItem[kKeyIndex] = index
        
        let folderItem:[String:Any] = [
            kKeyFolder:hasheableItem]
        
        return folderItem
    }
    
    private class func factoryElements(
        elements:[DVitaItemElement],
        index:Int) -> [[String:Any]]
    {
        var index:Int = index
        var items:[[String:Any]] = []
        
        for element:DVitaItemElement in elements
        {
            let fileItem:[String:Any] = factoryFileItem(
                item:element,
                index:index)
            
            index += 1
            items.append(fileItem)
        }
        
        return items
    }
    
    private class func factoryFileItem(
        item:DVitaItemElement,
        index:Int) -> [String:Any]
    {
        var hasheableItem:[String:Any] = item.hasheableItem
        hasheableItem[kKeyIndex] = index
        
        let fileItem:[String:Any] = [
            kKeyFile:hasheableItem]
        
        return fileItem
    }
    
    private class func factoryMetaData(
        items:[[String:Any]],
        completion:@escaping((Data?) -> ()))
    {
        let metaData:[String:[[String:Any]]] = [
            kKeyRoot:items]
        
        Xml.data(object:metaData)
        { (data:Data?, error:XmlError?) in
            
            completion(data)
        }
    }
    
    //MARK: internal
    
    class func factoryMetaData(
        items:[DVitaItem],
        completion:@escaping((Data?) -> ()))
    {
        let xml:String = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?><objectMetadata><folder ohfiParent=\"14\" name=\"ULUS105840000\" dateTimeUpdated=\"2017-08-31T06:35:31+00:00\" dateTimeCreated=\"2017-08-30T06:27:04+00:00\" savedataTitle=\"ULUS105840000\" size=\"152220\" title=\"ULUS105840000\" dirName=\"ULUS105840000\" type=\"1\" ohfi=\"14\" detail=\"\" index=\"0\" /></objectMetadata>"
        let data:Data = xml.data(using:String.Encoding.utf8, allowLossyConversion:false)!
        completion(data)
        
        return
        
        
        
        
        
        
        
        
        var index:Int = 0
        var hasheables:[[String:Any]] = []
        
        for item:DVitaItem in items
        {
            let hashItems:[[String:Any]] = factoryItems(
                item:item,
                index:index)
            
            index += hashItems.count
            hasheables.append(contentsOf:hashItems)
        }
        
        factoryMetaData(
            items:hasheables,
            completion:completion)
    }
}
