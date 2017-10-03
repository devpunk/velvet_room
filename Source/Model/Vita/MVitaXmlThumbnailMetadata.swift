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
        let model:[String:Any] = [
            MVitaXml.kKeyCodecType:kCodecType,
            MVitaXml.kKeyWidth:kWidth,
            MVitaXml.kKeyHeight:kHeight,
            MVitaXml.kKeyType:kType,
            MVitaXml.kKeyOrientationType:kOrientationType,
            MVitaXml.kAspectRatio:kAspectRatio,
            MVitaXml.kFromType:kFromType,
            MVitaXml.kKeyOhfi:14,
            MVitaXml.kKeySize:2,
            MVitaXml.kKeyDateTimeUpdated:"2017-08-31T06:35:31+00:00"]
        
        return model
    }
    
    //MARK: internal
    
    class func factoryMetadata(
        completion:@escaping((Data?) -> ()))
    {
        let model:[String:Any] = factoryMetadataModel()
        
        Xml.data(object:model)
        { (data:Data?, error:XmlError?) in
            
            completion(data)
        }
    }
}
