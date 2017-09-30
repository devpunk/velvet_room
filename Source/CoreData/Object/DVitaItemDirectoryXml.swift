import Foundation

extension DVitaItemDirectory
{
    func hasheableItem() -> Any? {
        let root:[String:Any] = [
            "objectMetadata":[
                "folder":[
                    "type":directoryType,
                    "name":self.name!,
                    "title":self.name!,
                    "index":0,
                    "ohfiParent":rawCategory,
                    "ohfi":rawCategory,
                    "dateTimeCreated":0]]]
        
        return root
    }
}
