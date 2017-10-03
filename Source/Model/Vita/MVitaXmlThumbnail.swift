import Foundation

final class MVitaXmlThumbnail
{
    //MARK: private
    
    private init() { }
    
    //MARK: private
    
    private class func factoryMetadata(
        thumbnailData:Data,
        item:DVitaItemDirectory,
        completion:@escaping((Data?) -> ()))
    {
        factoryXmlMetadata(thumbnailData:thumbnailData)
        { (xmlData:Data?) in
            
            guard
            
                let xmlData:Data = xmlData
            
            else
            {
                completion(nil)
                
                return
            }
            
            factoryMetadata(
                thumbnailData:thumbnailData,
                xmlData:xmlData,
                item:item,
                completion:completion)
        }
    }
    
    private class func factoryMetadata(
        thumbnailData:Data,
        xmlData:Data,
        item:DVitaItemDirectory,
        completion:((Data?) -> ()))
    {
        let thumbnailSize:UInt64 = UInt64(item.size)
        
        var data:Data = Data()
        data.append(xmlData)
        data.append(value:thumbnailSize)
        data.append(thumbnailData)
        
        completion(data)
    }
    
    //MARK: internal
    
    class func factoryMetadata(
        item:DVitaItemDirectory,
        completion:@escaping((Data?) -> ()))
    {
        guard
        
            let thumbnailData:Data = factoyThumbnailData(
                item:item)
        
        else
        {
            completion(nil)
            
            return
        }
        
        factoryMetadata(
            thumbnailData:thumbnailData,
            item:item,
            completion:completion)
    }
}
