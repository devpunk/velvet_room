import Foundation

class MMenu
{
    var selected:MMenu.Order
    let items:[MMenuItemProtocol]
    private let kInitialSelected:MMenu.Order = MMenu.Order.home
    
    init()
    {
        selected = kInitialSelected
        items = MMenu.factoryItems()
    }
}
