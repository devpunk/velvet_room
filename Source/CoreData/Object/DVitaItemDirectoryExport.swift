import Foundation

extension DVitaItemDirectory:DVitaItemExportProtocol
{
    var hasheableItem:Any?
    {
        get
        {
            let dateCreated:Date = Date(
                timeIntervalSince1970:self.dateCreated)
            let dateModified:Date = Date(
                timeIntervalSince1970:self.dateModified)
            let dateCreatedString:String = MVitaPtpDate.factoryString(
                date:dateCreated)
            let dateModifiedString:String = MVitaPtpDate.factoryString(
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
                        "dateTimeUpdated":dateModifiedString,
                        "dateTimeCreated":dateCreatedString]]]
            
            return root
        }
    }
}
