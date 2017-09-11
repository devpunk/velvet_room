import UIKit

class VConnect:ViewMain
{
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
        guard
            
            let controller:CConnect = self.controller as? CConnect,
            let viewType:View<ArchConnect>.Type = controller.model.status?.viewType
            
        else
        {
            return
        }
        
        let view:View<ArchConnect> = viewType.init(controller:controller)
        
        addSubview(view)
        
        NSLayoutConstraint.equals(
            view:view,
            toView:self)
    }
}
