import Foundation
import XmlHero

extension DVitaItemDirectory
{
    private func exportAsObject() -> Any
    {
        let root:[String:Any] = [
            "objectMetadata":[
                "folder":[
                    "type":"1",
                    "name":self.name!,
                    "title":self.name!,
                    "index":0,
                    "ohfiParent":rawCategory,
                    "ohfi":rawCategory,
                    "dateTimeCreated":0]]]
        
        return root
    }
    
    //MARK: internal
    
    func export(completion:@escaping((Data?) -> ()))
    {
        let object:Any = exportAsObject()
        
        Xml.data(object:object)
        { (data:Data?, error:XmlError?) in
            
            completion(data)
        }
    }
}
