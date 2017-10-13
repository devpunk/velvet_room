import Foundation

extension MSaveData
{
    //MARK: internal
    
    class func factoryItems() -> [MSaveDataProtocol]
    {
        let itemTitle:MSaveDataTitle = MSaveDataTitle()
        
        let items:[MSaveDataProtocol] = [
            itemTitle]
        
        return items
    }
}
