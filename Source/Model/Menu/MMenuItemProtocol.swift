import UIKit

protocol MMenuItemProtocol
{
    associatedtype A where A.M:Model<A>
    
    var icon:UIImage { get }
    var order:MMenu.Order { get }
    var controller:Controller<A> { get }
    
    init(order:MMenu.Order)
    
    func selected() -> UIViewController
}
