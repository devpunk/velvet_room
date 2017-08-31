import UIKit

protocol MMenuItemProtocol
{
    associatedtype A where A.M:Model<A>
    
    var icon:UIImage { get }
    var order:MMenu.Order { get }
    var controllerType:Controller<A>.Type { get }
}

class MMenuItem
{
    let icon:UIImage
    let order:MMenu.Order
    
    init<I:MMenuItemProtocol>(item:I)
    {
        icon = item.icon
        order = item.order
    }
}
