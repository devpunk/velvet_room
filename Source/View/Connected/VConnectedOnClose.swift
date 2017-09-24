import UIKit

final class VConnectedOnClose:View<ArchConnected>
{
    private weak var layoutButtonLeft:NSLayoutConstraint!
    private let kButtonWidth:CGFloat = 100
    
    required init(controller:CConnected)
    {
        super.init(controller:controller)
        
        let button:UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(
            #imageLiteral(resourceName: "assetConnectClose"),
            for:UIControlState.normal)
        button.imageView!.clipsToBounds = true
        button.imageView!.contentMode = UIViewContentMode.center
        button.addTarget(
            self,
            action:#selector(selectorClose(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(button)
        
        NSLayoutConstraint.equalsVertical(
            view:button,
            toView:self)
        NSLayoutConstraint.width(
            view:button,
            constant:kButtonWidth)
        layoutButtonLeft = NSLayoutConstraint.leftToLeft(
            view:button,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.width
        let remainWidth:CGFloat = width - kButtonWidth
        let marginLeft:CGFloat = remainWidth / 2.0
        layoutButtonLeft.constant = marginLeft
        
        super.layoutSubviews()
    }
    
    //MARK: selectors
    
    @objc
    private func selectorClose(sender button:UIButton)
    {
        controller.close()
    }
}
