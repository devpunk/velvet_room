import UIKit

struct MMenuItemHome:MMenuItemProtocol
{
    let order:MMenu.Order = MMenu.Order.connect
    let icon:UIImage = #imageLiteral(resourceName: "assetGenericMenuHome")
    let controllerType:UIViewController.Type = CHome.self
}
