import Foundation

class MVitaItemIn
{
    var dateModified:Date?
    var name:String?
    let format:MVitaItemFormat
    let treatId:UInt32
    
    init(
        format:MVitaItemFormat,
        treatId:UInt32)
    {
        self.format = format
        self.treatId = treatId
    }
}
