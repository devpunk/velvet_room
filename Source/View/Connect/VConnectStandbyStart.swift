import UIKit

class VConnectStandbyStart:View<ArchConnect>
{
    private weak var layoutButtonLeft:NSLayoutConstraint!
    private let kButtonWidth:CGFloat = 200
    
    required init(controller:CConnect)
    {
        super.init(controller:controller)
        
        let button:UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(
            String.localizedView(key:"VConnectStandbyStart_button"),
            for:UIControlState.normal)
        button.setTitleColor(
            UIColor.white,
            for:UIControlState.normal)
        button.setTitleColor(
            UIColor(white:1, alpha:0.2),
            for:UIControlState.highlighted)
        button.titleLabel!.font = UIFont.medium(size:15)
        button.addTarget(
            self,
            action:#selector(selectorButton(sender:)),
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
        let buttonLeft:CGFloat = remainWidth / 2.0
        layoutButtonLeft.constant = buttonLeft
        
        super.layoutSubviews()
    }
    
    //MARK: selectors
    
    @objc
    private func selectorButton(sender button:UIButton)
    {
        
    }
}
