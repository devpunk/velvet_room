import Foundation

extension DVitaItemDirectory:DVitaItemExportProtocol
{
    var hasheableItem:Any?
    {
        get
        {
            let dateModified:Date = Date(
                timeIntervalSince1970:self.dateModified)
            let dateString:String = MVitaPtpDate.factoryString(
                date:dateModified)
            
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
                        "dateTimeUpdated":dateString,
                        "dateTimeCreated":dateString]]]
            
            return root
        }
    }
}
