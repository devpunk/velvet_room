import Foundation

extension DVitaItemElement:DVitaItemExportProtocol
{
    var hasheableItem:[String:Any]?
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
            let name:String = self.name!
            
            let root:[String:Any] = [
                "statusType":0,
                "name":name,
                "title":name,
                //                                        "index":0,
                "ohfiParent":directory!.category.rawValue,
                "ohfi":directory!.category.rawValue,
                "size":size,
                "dateTimeCreated":dateCreatedString,
                "dateTimeUpdated":dateModifiedString]
            
            return root
        }
    }
}
