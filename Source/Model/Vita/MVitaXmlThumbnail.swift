import Foundation

final class MVitaXmlThumbnail
{
    //MARK: private
    
    private init() { }
    
    //MARK: private
    
    private class func factoryMetadata(
        thumbnailData:Data,
        directory:DVitaItemDirectory,
        completion:@escaping((Data?) -> ()))
    {
        factoryXml(thumbnailData:thumbnailData)
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
                directory:directory,
                completion:completion)
        }
    }
    
    private class func factoryMetadata(
        thumbnailData:Data,
        xmlData:Data,
        directory:DVitaItemDirectory,
        completion:((Data?) -> ()))
    {
        let thumbnailSize:UInt64 = UInt64(directory.size)
        
        var data:Data = Data()
        data.append(xmlData)
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
            directory:directory,
            completion:completion)
    }
}
