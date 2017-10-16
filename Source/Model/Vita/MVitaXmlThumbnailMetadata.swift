import Foundation
import XmlHero

extension MVitaXmlThumbnail
{
    //MARK: private
    
    private class func factoryMetadataModel() -> [String:Any]
    {
        let modelContent:[String:Any] = factoryContentModel()
        let modelThumbnail:[String:Any] = [
            MVitaXml.kKeyThumbnail:modelContent]
        let model:[String:Any] = [
            MVitaXml.kKeyObjectMetadata:modelThumbnail]
        
        return model
    }
    
    private class func factoryContentModel() -> [String:Any]
    {
        let model:[String:Any] = [:]
        
        return model
    }
    
    //MARK: internal
    
    class func factoryXml(completion:@escaping((Data?) -> ()))
    {
        let model:[String:Any] = factoryMetadataModel()
        
        Xml.data(object:model)
        { (data:Data?, error:XmlError?) in
            
            completion(data)
        }
    }
}
