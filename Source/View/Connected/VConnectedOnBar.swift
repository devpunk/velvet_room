import UIKit

final class VConnectedOnBar:View<ArchConnected>
{
    private let kTitleTop:CGFloat = 20
    private let kFontSize:CGFloat = 18
    private let kBorderHeight:CGFloat = 1
    
    required init(controller:CConnected)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.white
        isUserInteractionEnabled = false
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.textColor = UIColor.colourBackgroundDark
        labelTitle.font = UIFont.medium(
            size:kFontSize)
        labelTitle.text = String.localizedView(
            key:"VConnectedOnBar_labelTitle")
        
        let border:VBorder = VBorder(
            colour:UIColor(white:0, alpha:0.2))
        
        addSubview(labelTitle)
        addSubview(border)
        
        NSLayoutConstraint.topToTop(
            view:labelTitle,
            toView:self,
            constant:kTitleTop)
        NSLayoutConstraint.bottomToBottom(
            view:labelTitle,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:labelTitle,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
