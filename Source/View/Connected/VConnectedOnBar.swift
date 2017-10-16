import UIKit

final class VConnectedOnBar:View<ArchConnected>
{
    private weak var layoutIconLeft:NSLayoutConstraint!
    private let kIconWidth:CGFloat = 35
    private let kIconLeft:CGFloat = -48
    private let kTitleWidth:CGFloat = 130
    private let kContentTop:CGFloat = 20
    private let kFontSize:CGFloat = 20
    private let kBorderHeight:CGFloat = 1
    
    required init(controller:CConnected)
    {
        super.init(controller:controller)
        isUserInteractionEnabled = false
        
        let icon:UIImageView = UIImageView()
        icon.isUserInteractionEnabled = false
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.clipsToBounds = true
        icon.contentMode = UIViewContentMode.center
        icon.image = #imageLiteral(resourceName: "assetConnectTitle")
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.textColor = UIColor.colourBackgroundDark
        labelTitle.font = UIFont.regular(
            size:kFontSize)
        labelTitle.text = String.localizedView(
            key:"VConnectedOnBar_labelTitle")
        
        addSubview(icon)
        addSubview(labelTitle)
        
        NSLayoutConstraint.topToTop(
            view:icon,
            toView:self,
            constant:kContentTop)
        layoutIconLeft = NSLayoutConstraint.leftToLeft(
            view:icon,
            toView:self)
        NSLayoutConstraint.width(
            view:icon,
            constant:kIconWidth)
        NSLayoutConstraint.bottomToBottom(
            view:icon,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:labelTitle,
            toView:self,
            constant:kContentTop)
        NSLayoutConstraint.bottomToBottom(
            view:labelTitle,
            toView:self)
        NSLayoutConstraint.width(
            view:labelTitle,
            constant:kTitleWidth)
        NSLayoutConstraint.leftToRight(
            view:labelTitle,
            toView:icon)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.width
        let width_2:CGFloat = width / 2.0
        let marginLeft:CGFloat = width_2 + kIconLeft
        layoutIconLeft.constant = marginLeft
        
        super.layoutSubviews()
    }
}
