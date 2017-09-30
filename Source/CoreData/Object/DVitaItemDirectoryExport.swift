import Foundation

extension DVitaItemDirectory:DVitaItemExportProtocol
{
    var hasheableItem:Any?
    {
        get
        {
            let root:[String:Any] = [
                "objectMetadata":[
                    "folder":[
                        "type":directoryType,
                        "name":self.name!,
                        "title":self.name!,
                        "index":0,
                        "ohfiParent":rawCategory,
                        "ohfi":rawCategory,
                        "size":size,
                        "dateTimeCreated":0]]]
            
            return root
        }
    }
}
