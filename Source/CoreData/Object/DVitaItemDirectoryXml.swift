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
                    "index":"0",
                    "ohfiParent":"14",
                    "ohfi":"9283",
                    "dateTimeCreated":"0"]]]
        
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
