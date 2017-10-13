import Foundation

extension MSaveData
{
    //MARK: internal
    
    class func factoryContent(
        coredataModel:DVitaIdentifier) -> [MSaveDataProtocol]
    {
        var items:[MSaveDataProtocol] = []
        
        if let itemTitle:MSaveDataTitle = MSaveDataTitle(
            coredataModel:coredataModel)
        {
            items.append(itemTitle)
        }
        
        return items
    }
}
