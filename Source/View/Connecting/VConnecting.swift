import UIKit

final class VConnecting:ViewMain
{
    private weak var viewStatus:View<ArchConnecting>?
    private weak var buttonCancel:UIButton!
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
        
        let buttonCancel:UIButton = UIButton()
        buttonCancel.translatesAutoresizingMaskIntoConstraints = false
        buttonCancel.setTitleColor(
            UIColor(white:1, alpha:0.6),
            for:UIControlState.normal)
        buttonCancel.setTitleColor(
            UIColor(white:1, alpha:0.2),
            for:UIControlState.highlighted)
        buttonCancel.titleLabel!.font = UIFont.regular(size:17)
        buttonCancel.setTitle(
            String.localizedView(key:"VConnecting_buttonCancel"),
            for:UIControlState.normal)
        buttonCancel.addTarget(
            self,
            action:#selector(selectorCancel(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonCancel = buttonCancel
        
        addSubview(viewGradient)
        addSubview(buttonCancel)
        
        NSLayoutConstraint.equals(
            view:viewGradient,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:buttonCancel,
            toView:self,
            constant:kCancelBottom)
        NSLayoutConstraint.height(
            view:buttonCancel,
            constant:kCancelHeight)
        NSLayoutConstraint.width(
            view:buttonCancel,
            constant:kCancelWidth)
        layoutCancelLeft = NSLayoutConstraint.leftToLeft(
            view:buttonCancel,
            toView:self)
    }
    
    //MARK: public
    
    func updateStatus()
    {
        self.viewStatus?.removeFromSuperview()
        
        guard
        
            let controller:CConnecting = self.controller as? CConnecting,
            let status:MConnectingStatusProtocol = controller.model.status
        
        else
        {
            return
        }
        
        let viewType:View<ArchConnecting>.Type = status.viewType
        let viewStatus:View<ArchConnecting> = viewType.init(
            controller:controller)
        self.viewStatus = viewStatus
        
        insertSubview(viewStatus, belowSubview:buttonCancel)
        
        NSLayoutConstraint.equals(
            view:viewStatus,
            toView:self)
    }
}
