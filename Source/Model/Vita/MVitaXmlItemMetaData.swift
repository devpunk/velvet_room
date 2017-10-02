import Foundation
import XmlHero

final class MVitaXmlItemMetaData
{
    private static let kKeyRoot:String = "objectMetadata"
    private static let kKeyFolder:String = "folder"
    private static let kKeyIndex:String = "index"
    
    //MARK: private
    
    private init() { }
    
    private class func factoryFolderItem(
        item:DVitaItem,
        index:Int) -> [String:Any]?
    {
        guard
            
            let itemExport:DVitaItemExportProtocol = item as? DVitaItemExportProtocol,
            let hasheableItem:[String:Any] = itemExport.hasheableItem
            
        else
        {
            return nil
        }
        
        var editItem:[String:Any] = hasheableItem
        editItem[kKeyIndex] = index
        
        let folderItem:[String:Any] = [
            kKeyFolder:editItem]
        
        return folderItem
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
        var index:Int = 0
        var hasheables:[[String:Any]] = []
        
        for item:DVitaItem in items
        {
            guard
                
                let folderItem:[String:Any] = factoryFolderItem(
                    item:item,
                    index:index)
            
            else
            {
                continue
            }
            
            hasheables.append(folderItem)
            index += 1
        }
        
        factoryMetaData(
            items:hasheables,
            completion:completion)
    }
}
