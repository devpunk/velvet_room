import Foundation

extension DVitaItem
{
    //MARK: export protocol
    
    func hasheableItem() -> Any?
    {
        return nil
    }
    
    //MARK: internal
    
    final func export(completion:@escaping((Data?) -> ()))
    {
        guard
            
            let object:Any = hasheableItem()
        
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
