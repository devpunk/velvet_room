import Foundation

final class MVitaXmlThumbnail
{
    //MARK: private
    
    private init() { }
    
    //MARK: private
    
    private class func factoryMetadata(
        thumbnailData:Data,
        completion:@escaping((Data?) -> ()))
    {
        factoryXml
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
                completion:completion)
        }
    }
    
    private class func factoryMetadata(
        thumbnailData:Data,
        xmlData:Data,
        completion:((Data?) -> ()))
    {
        let wrappedXml:Data = MVitaLink.wrapDataWithSizeHeader(
            data:xmlData)
        let thumbnailSize:UInt64 = UInt64(thumbnailData.count)
        
        var data:Data = Data()
        data.append(wrappedXml)
        data.append(value:thumbnailSize)
        data.append(thumbnailData)
        
        completion(data)
    }
    
    //MARK: internal
    
    class func factoryMetadata(
        directory:DVitaItemDirectory,
        completion:@escaping((Data?) -> ()))
    {
        guard
        
            let thumbnailData:Data = factoyThumbnail(
                directory:directory)
        
        else
        {
            completion(nil)
            
            return
        }
        
        factoryMetadata(
            thumbnailData:thumbnailData,
            completion:completion)
    }
}
