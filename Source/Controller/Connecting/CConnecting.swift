import UIKit

final class CConnecting:Controller<ArchConnecting>
{
    private let kSubtractCurrentController:Int = 2
    
    override var preferredStatusBarStyle:UIStatusBarStyle
    {
        get
        {
            return UIStatusBarStyle.lightContent
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        model.start()
    }
    
    //MARK: private
    
    private func asyncConnectionReady()
    {
        guard
            
            let vitaLink:MVitaLink = model.vitaLink
        
        else
        {
            return
        }
        
        model.vitaLink = nil
        let controller:CConnected = CConnected()
        controller.model.start(
            vitaLink:vitaLink)
        
        parentController?.push(
            controller:controller,
            horizontal:ControllerParent.Horizontal.right)
        { [weak self] in
            
            self?.dismissConnecting()
        }
    }
    
    private func dismissConnecting()
    {
        guard
            
            let totalControllers:Int = parentController?.childViewControllers.count
        
        else
        {
            return
        }
        
        let currentController:Int = totalControllers - kSubtractCurrentController
        
        parentController?.popSilent(
            removeIndex:currentController)
    }
    
    //MARK: internal
    
    func cancelConnection()
    {
        model.cancelAndClean()
        parentController?.pop(vertical:ControllerParent.Vertical.bottom)
    }
    
    func connectionReady()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.asyncConnectionReady()
        }
    }
}
