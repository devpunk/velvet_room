import Foundation
import XmlHero

extension MVitaXmlThumbnail
{
    private static let kAspectRatio:String = "1,000000"
    private static let kCodecType:Int = 18
    private static let kWidth:Int = 144
    private static let kHeight:Int = 80
    private static let kType:Int = 0
    private static let kOrientationType:Int = 1
    private static let kFromType:Int = 2
    
    //MARK: private
    
    private class func factoryMetadataModel(
        thumbnailData:Data) -> [String:Any]
    {
        let modelContent:[String:Any] = factoryContentModel(
            thumbnailData:thumbnailData)
        let modelThumbnail:[String:Any] = [
            MVitaXml.kKeyThumbnail:modelContent]
        let model:[String:Any] = [
            MVitaXml.kKeyObjectMetadata:modelThumbnail]
        
        return model
    }
    
    private class func factoryContentModel(
        thumbnailData:Data) -> [String:Any]
    {
        let model:[String:Any] = [:]
        
        return model
    }
    
    //MARK: internal
    
    class func factoryXml(
        thumbnailData:Data,
        completion:@escaping((Data?) -> ()))
    {
        let model:[String:Any] = factoryMetadataModel(
            thumbnailData:thumbnailData)
        
        Xml.data(object:model)
        { (data:Data?, error:XmlError?) in
            
            completion(data)
        }
    }
}
