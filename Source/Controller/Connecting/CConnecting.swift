import UIKit

final class CConnecting:Controller<ArchConnecting>
{
    override var preferredStatusBarStyle:UIStatusBarStyle
    {
        get
        {
            return UIStatusBarStyle.lightContent
        }
    }
    
    //MARK: internal
    
    func cancelConnection()
    {
        parentController?.pop(vertical:ControllerParent.Vertical.bottom)
    }
}
