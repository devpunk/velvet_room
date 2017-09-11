import UIKit

extension VConnectStandby
{
    //MARK: internal
    
    func factoryViews()
    {
        let viewWalk:VConnectStandbyWalk = VConnectStandbyWalk(
            controller:controller)
        
        let viewStart:VConnectStandbyStart = VConnectStandbyStart(
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
