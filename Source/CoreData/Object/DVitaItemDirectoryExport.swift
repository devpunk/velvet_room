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
            let name:String = self.identifier!.identifier!
            
            let root:[String:Any] = [
                "objectMetadata":[
                    "folder":[
//                        "type":directoryType,
                        "name":name,
//                        "title":name,
//                        "index":0,
//                        "ohfiParent":rawCategory,
//                        "ohfi":rawCategory,
                        "size":size,
//                        "dateTimeCreated":dateCreatedString,
                        "dateTimeUpdated":dateModifiedString
                    ]]]
            
            return root
        }
    }
}
