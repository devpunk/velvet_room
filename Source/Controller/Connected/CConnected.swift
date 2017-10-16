import UIKit

final class CConnected:Controller<ArchConnected>
{
    //MARK: private
    
    private func confirmClose()
    {
        model.closeConnection()
    }
    
    //MARK: internal
    
    func close()
    {
        let alert:UIAlertController = UIAlertController(
            title:String.localizedController(key:"CConnected_alertCloseTitle"),
            message:nil,
            preferredStyle:UIAlertControllerStyle.actionSheet)
        
        let actionCancel:UIAlertAction = UIAlertAction(
            title:String.localizedController(key:"CConnected_alertCloseCancel"),
            style:UIAlertActionStyle.cancel)
        
        let actionAccept:UIAlertAction = UIAlertAction(
            title:String.localizedController(key:"CConnected_alertCloseAccept"),
            style:UIAlertActionStyle.destructive)
        { [weak self] (action:UIAlertAction) in
            
            self?.confirmClose()
        }
        
        alert.addAction(actionAccept)
        alert.addAction(actionCancel)
        
        if let popover:UIPopoverPresentationController = alert.popoverPresentationController
        {
            popover.sourceView = view
            popover.sourceRect = CGRect.zero
            popover.permittedArrowDirections = UIPopoverArrowDirection.up
        }
        
        present(alert, animated:true, completion:nil)
    }
    
    func connectionClosed()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.parentController?.pop(
                horizontal:ControllerParent.Horizontal.right)
        }
    }
}
