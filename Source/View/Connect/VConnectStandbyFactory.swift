import UIKit

extension VConnectStandby
{
    //MARK: internal
    
    func factoryViews()
    {
        let viewStart:VConnectStandbyStart = VConnectStandbyStart(
            controller:controller)
        
        addSubview(viewStart)
        
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
