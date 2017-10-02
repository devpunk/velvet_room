import Foundation
import XmlHero

final class MVitaXmlItemMetaData
{
    private static let kKeyRoot:String = "objectMetadata"
    private static let kKeyIndex:String = "index"
    
    //MARK: private
    
    private init() { }
    
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
            
                let itemExport:DVitaItemExportProtocol = item as? DVitaItemExportProtocol,
                var hasheableItem:[String:Any] = itemExport.hasheableItem
            
            else
            {
                continue
            }
            
            hasheableItem[kKeyIndex] = index
            hasheables.append(hasheableItem)
            index += 1
        }
        
        factoryMetaData(
            items:hasheables,
            completion:completion)
    }
}
