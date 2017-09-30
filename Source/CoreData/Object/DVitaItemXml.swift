import Foundation
import XmlHero

extension DVitaItem
{
    //MARK: internal
    
    final func export(completion:@escaping((Data?) -> ()))
    {
        guard
            
            let object:Any = exportAsObject()
        
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
