import Foundation
import XmlHero

final class MVitaXmlThumbnail
{
    //MARK: private
    
    private init() { }
    
    //MARK: internal
    
    class func factoryMetadata(
        item:DVitaItemDirectory,
        completion:@escaping((Data?) -> ()))
    {
        guard
        
            let data:Data = factoyThumbnailData(
                item:item)
        
        else
        {
            completion(nil)
            
            return
        }
    }
}
