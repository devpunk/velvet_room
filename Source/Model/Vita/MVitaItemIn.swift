import Foundation

class MVitaItemIn
{
    var dateCreated:Date?
    var dateModified:Date?
    var name:String?
    var size:UInt64
    let format:MVitaItemFormat
    let treatId:UInt32
    private(set) var localName:String?
    
    init(
        format:MVitaItemFormat,
        treatId:UInt32)
    {
        self.format = format
        self.treatId = treatId
        size = 0
    }
    
    //MARK: internal
    
    final func generateLocalName()
    {
        localName = UUID().uuidString
    }
    
    func requestContent(
        strategy:MVitaLinkStrategyRequestItemTreat) { }
}
