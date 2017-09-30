import Foundation
import XmlHero

extension DVitaItemExportProtocol
{
    func export(completion:@escaping((Data?) -> ()))
    {
        guard
            
            let object:Any = hasheableItem
            
        else
        {
            completion(nil)
            
            return
        }
        
        Xml.data(object:object)
        { (data:Data?, error:XmlError?) in
            
            completion(data)
        }
    }
}
