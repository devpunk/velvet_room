import UIKit

extension VConnected
{
    //MARK: private
    
    private func asyncUpdateStatus()
    {
        self.viewStatus?.removeFromSuperview()
        
        guard
            
            let controller:CConnected = self.controller as? CConnected,
            let status:MConnectedStatusProtocol = controller.model.status
            
        else
        {
            return
        }
        
        let viewType:View<ArchConnected>.Type = status.viewType
        let viewStatus:View<ArchConnected> = viewType.init(
            controller:controller)
        self.viewStatus = viewStatus
        
        addSubview(viewStatus)
        
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
            self?.updateEvents()
        }
    }
}
