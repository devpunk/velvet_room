import UIKit

final class VConnect:ViewMain
{
    private let kStartHeight:CGFloat = 64
    private let kStartBottom:CGFloat = -90
    
    required init(controller:UIViewController)
    {
        super.init(controller:controller)
        
        guard
        
            let controller:CConnect = controller as? CConnect
        
        else
        {
            return
        }
        
        factoryViews(controller:controller)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: internal
    
    func factoryViews(controller:CConnect)
    {
        let viewWalk:VConnectWalk = VConnectWalk(
            controller:controller)
        
        let viewStart:VConnectStart = VConnectStart(
            controller:controller)
        
        addSubview(viewWalk)
        addSubview(viewStart)
        
        NSLayoutConstraint.equals(
            view:viewWalk,
            toView:self)
        
        NSLayoutConstraint.height(
            view:viewStart,
            constant:kStartHeight)
        NSLayoutConstraint.bottomToBottom(
            view:viewStart,
            toView:self,
            constant:kStartBottom)
        NSLayoutConstraint.equalsHorizontal(
            view:viewStart,
            toView:self)
    }
}
