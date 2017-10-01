import Foundation

class MVitaItemIn
{
    var dateCreated:Date?
    var dateModified:Date?
    var name:String?
    var size:UInt64
    let format:MVitaItemFormat
    let localName:String
    let treatId:UInt32
    
    init(
        format:MVitaItemFormat,
        treatId:UInt32)
    {
        self.format = format
        self.treatId = treatId
        localName = UUID().uuidString
        size = 0
    }
    
    //MARK: internal
    
    func requestContent(
        strategy:MVitaLinkStrategyRequestItemTreat) { }
}
