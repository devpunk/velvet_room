import UIKit

final class VConnecting:ViewMain
{
    weak var viewStatus:View<ArchConnecting>?
    private(set) weak var button:UIButton!
    private weak var layoutCancelLeft:NSLayoutConstraint!
    private let kCancelBottom:CGFloat = -80
    private let kCancelHeight:CGFloat = 45
    private let kCancelWidth:CGFloat = 140
    
    required init(controller:UIViewController)
    {
        super.init(controller:controller)
        
        guard
        
            let controller:CConnecting = controller as? CConnecting
        
        else
        {
            return
        }
        
        factoryViews(controller:controller)
        updateStatus()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.width
        let remainCancel:CGFloat = width - kCancelWidth
        let cancelLeft:CGFloat = remainCancel / 2.0
        layoutCancelLeft.constant = cancelLeft
        
        super.layoutSubviews()
    }
    
    //MARK: selectors
    
    @objc
    private func selectorCancel(sender button:UIButton)
    {
        guard
        
            let controller:CConnecting = self.controller as? CConnecting
        
        else
        {
            return
        }
        
        controller.cancelConnection()
    }
    
    //MARK: private
    
    private func factoryViews(controller:CConnecting)
    {
        let viewGradient:VGradient = VGradient.vertical(
            colourTop:UIColor.colourGradientLight,
            colourBottom:UIColor.colourGradientDark)
        
        let button:UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(
            UIColor(white:1, alpha:0.6),
            for:UIControlState.normal)
        button.setTitleColor(
            UIColor(white:1, alpha:0.2),
            for:UIControlState.highlighted)
        button.titleLabel!.font = UIFont.regular(size:17)
        button.addTarget(
            self,
            action:#selector(selectorCancel(sender:)),
            for:UIControlEvents.touchUpInside)
        self.button = button
        
        addSubview(viewGradient)
        addSubview(button)
        
        NSLayoutConstraint.equals(
            view:viewGradient,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:button,
            toView:self,
            constant:kCancelBottom)
        NSLayoutConstraint.height(
            view:button,
            constant:kCancelHeight)
        NSLayoutConstraint.width(
            view:button,
            constant:kCancelWidth)
        layoutCancelLeft = NSLayoutConstraint.leftToLeft(
            view:button,
            toView:self)
    }
}
