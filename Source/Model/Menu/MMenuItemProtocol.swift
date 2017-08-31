import UIKit

protocol MMenuItemProtocol
{
    var icon:UIImage { get }
    var order:MMenu.Order { get }
    var controllerType:UIViewController.Type { get }
}
