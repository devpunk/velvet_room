import UIKit

final class VConnectedOnEventsCellPicture:VConnectedOnEventsCell
{
    private let kBaseMargin:CGFloat = 1
    private let kCornerRadius:CGFloat = 7
    private let kBorderWidth:CGFloat = 1
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        backgroundColor = UIColor.clear
        clipsToBounds = true
        isUserInteractionEnabled = false
        
        let viewBaseHeight:CGFloat = frame.width
        let viewBase:UIView = UIView()
        viewBase.isUserInteractionEnabled = false
        viewBase.translatesAutoresizingMaskIntoConstraints = false
        viewBase.clipsToBounds = true
        viewBase.layer.cornerRadius = kCornerRadius
        viewBase.layer.borderWidth = kBorderWidth
        viewBase.layer.borderColor = UIColor.black.cgColor
        
        addSubview(viewBase)
        
        NSLayoutConstraint.topToTop(
            view:viewBase,
            toView:self,
            constant:kBaseMargin)
        NSLayoutConstraint.height(
            view:viewBase,
            constant:viewBaseHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBase,
            toView:self,
            margin:kBaseMargin)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
