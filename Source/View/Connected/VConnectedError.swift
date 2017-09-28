import UIKit

final class VConnectedError:View<ArchConnected>
{
    private let kBarHeight:CGFloat = 150
    private let kInfoHeight:CGFloat = 220
    private let kCloseHeight:CGFloat = 60
    
    required init(controller:CConnected)
    {
        super.init(controller:controller)
        
        factoryViews()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: private
    
    private func factoryViews()
    {
        let viewBar:VConnectedErrorBar = VConnectedErrorBar(
            controller:controller)
        let viewInfo:VConnectedErrorInfo = VConnectedErrorInfo(
            controller:controller)
        let viewClose:VConnectedErrorClose = VConnectedErrorClose(
            controller:controller)
        
        addSubview(viewBar)
        addSubview(viewInfo)
        addSubview(viewClose)
        
        NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        NSLayoutConstraint.height(
            view:viewBar,
            constant:kBarHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:viewInfo,
            toView:viewBar)
        NSLayoutConstraint.height(
            view:viewInfo,
            constant:kInfoHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewInfo,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:viewClose,
            toView:viewInfo)
        NSLayoutConstraint.height(
            view:viewClose,
            constant:kCloseHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewClose,
            toView:self)
    }
}
