import Foundation

final class MVitaItemInDirectory:MVitaItemIn
{
    let category:MVitaItemCategory
    let directoryType:UInt32
    var rawElements:[UInt32]
    var elements:[MVitaItemInElement]
    var sfoTitle:String?
    var sfoSavedDataTitle:String?
    var sfoSavedDataDetail:String?
    
    init(itemTreat:MVitaItemTreat)
    {
        category = itemTreat.category
        directoryType = itemTreat.directoryType
        rawElements = []
        elements = []
        
        super.init(
            format:MVitaItemFormat.directory,
            treatId:itemTreat.treatId)
    }
    
    override func requestContent(
        strategy:MVitaLinkStrategyRequestItemTreat)
    {
        strategy.requestItemElements(
            treatId:treatId)
    }
}
