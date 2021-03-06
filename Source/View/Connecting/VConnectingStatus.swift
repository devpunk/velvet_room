import UIKit

extension VConnecting
{
    //MARK: private
    
    private func asyncUpdateStatus()
    {
        self.viewStatus?.removeFromSuperview()
        
        guard
            
            let controller:CConnecting = self.controller as? CConnecting,
            let status:MConnectingStatusProtocol = controller.model.status
            
        else
        {
            return
        }
        
        button.setTitle(
            status.buttonTitle,
            for:UIControlState.normal)
        
        let viewType:View<ArchConnecting>.Type = status.viewType
        let viewStatus:View<ArchConnecting> = viewType.init(
            controller:controller)
        self.viewStatus = viewStatus
        
        insertSubview(viewStatus, belowSubview:button)
        
        NSLayoutConstraint.equals(
            view:viewStatus,
            toView:self)
    }
    
    //MARK: internal
    
    func updateStatus()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.asyncUpdateStatus()
        }
    }
}
