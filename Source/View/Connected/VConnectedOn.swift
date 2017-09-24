import UIKit

final class VConnectedOn:View<ArchConnected>
{
    private(set) weak var viewEvents:VConnectedOnEvents!
    private let kBarHeight:CGFloat = 64
    private let kCloseBottom:CGFloat = -35
    private let kCloseHeight:CGFloat = 80
    
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
        let viewEvents:VConnectedOnEvents = VConnectedOnEvents(
            controller:controller)
        self.viewEvents = viewEvents
        
        let viewBar:VConnectedOnBar = VConnectedOnBar(
            controller:controller)
        
        let viewClose:VConnectedOnClose = VConnectedOnClose(
            controller:controller)
        
        addSubview(viewEvents)
        addSubview(viewBar)
        addSubview(viewClose)
        
        NSLayoutConstraint.equals(
            view:viewEvents,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        NSLayoutConstraint.height(
            view:viewBar,
            constant:kBarHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:viewClose,
            toView:self,
            constant:kCloseBottom)
        NSLayoutConstraint.height(
            view:viewClose,
            constant:kCloseHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewClose,
            toView:self)
    }
}
