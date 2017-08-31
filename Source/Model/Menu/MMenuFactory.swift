import Foundation

extension MMenu
{
    //MARK: private
    
    private class func factoryItemsList() -> [MMenuItemProtocol]
    {
        let itemConnect:MMenuItemConnect = MMenuItemConnect()
        
        let map:[MMenuItemProtocol] = [
            itemConnect]
        
        return map
    }
    
    //MARK: internal
    
    class func factoryItems() -> [MMenuItemProtocol]
    {
        var items:[MMenuItemProtocol] = factoryItemsList()
        
        items.sort
        { (itemA:MMenuItemProtocol, itemB:MMenuItemProtocol) -> Bool in
            
            return itemA.order.rawValue < itemB.order.rawValue
        }
        
        return items
    }
}
