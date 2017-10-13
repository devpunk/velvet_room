import Foundation

extension MSaveData
{
    //MARK: internal
    
    class func factoryContent() -> [MSaveDataProtocol]
    {
        let itemTitle:MSaveDataTitle = MSaveDataTitle()
        
        let items:[MSaveDataProtocol] = [
            itemTitle]
        
        return items
    }
}
