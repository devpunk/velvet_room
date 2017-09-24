import UIKit

final class VConnected:ViewMain
{
    weak var viewStatus:View<ArchConnected>?
    
    required init(controller:UIViewController)
    {
        super.init(controller:controller)
        updateStatus()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
