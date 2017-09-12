import UIKit

final class VConnect:ViewMain
{
    private weak var viewMain:View<ArchConnect>?
    
    required init(controller:UIViewController)
    {
        super.init(controller:controller)
        update()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: internal
    
    func update()
    {
        self.viewMain?.removeFromSuperview()
        
        guard
            
            let controller:CConnect = self.controller as? CConnect,
            let viewType:View<ArchConnect>.Type = controller.model.status?.viewType
            
        else
        {
            return
        }
        
        let viewMain:View<ArchConnect> = viewType.init(controller:controller)
        self.viewMain = viewMain
        
        addSubview(viewMain)
        
        NSLayoutConstraint.equals(
            view:viewMain,
            toView:self)
    }
}
