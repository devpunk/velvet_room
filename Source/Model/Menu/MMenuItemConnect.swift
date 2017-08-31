import UIKit

struct MMenuItemConnect:MMenuItemProtocol
{
    let order:MMenu.Order = MMenu.Order.connect
    let icon:UIImage = UIImage()
    let controllerType:UIViewController.Type = CConnect.self
}
