import Foundation

class MMenu
{
    var selected:MMenu.Order
    let items:[MMenuItem]
    private let kInitialSelected:MMenu.Order = MMenu.Order.connect
    
    init()
    {
        selected = kInitialSelected
        items = MMenu.factoryItems()
    }
}
