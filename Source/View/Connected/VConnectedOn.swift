import UIKit

final class VConnectedOn:View<ArchConnected>
{
    private let kBarHeight:CGFloat = 64
    
    required init(controller:CConnected)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.colourBackgroundGray
        
        factoryViews()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: private
    
    private func factoryViews()
    {
        let viewBar:VConnectedOnBar = VConnectedOnBar(
            controller:controller)
        
        addSubview(viewBar)
        
        NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        NSLayoutConstraint.height(
            view:viewBar,
            constant:kBarHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
    }
}
