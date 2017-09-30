import Foundation

final class MVitaItemInDirectory:MVitaItemIn
{
    let category:MVitaItemCategory
    var rawElements:[UInt32]
    var elements:[MVitaItemIn]
    var thumbnail:Data?
    
    init(itemTreat:MVitaItemTreat)
    {
        category = itemTreat.category
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
