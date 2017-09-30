import Foundation

class MVitaItemIn
{
    var dateModified:Date?
    var name:String?
    var size:UInt64
    let format:MVitaItemFormat
    let treatId:UInt32
    
    init(
        format:MVitaItemFormat,
        treatId:UInt32)
    {
        self.format = format
        self.treatId = treatId
        size = 0
    }
    
    //MARK: internal
    
    func requestContent(
        strategy:MVitaLinkStrategyRequestItemTreat) { }
}
