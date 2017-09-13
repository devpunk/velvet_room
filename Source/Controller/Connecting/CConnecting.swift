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
        model.cancelAndClean()
        parentController?.pop(vertical:ControllerParent.Vertical.bottom)
    }
}
