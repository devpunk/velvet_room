import UIKit

class VConnectedOnEventsCell:UICollectionViewCell
{
    private let kBaseMargin:CGFloat = 2
    private let kBaseBottom:CGFloat = -32
    private let kCornerRadius:CGFloat = 8
    private let kBorderWidth:CGFloat = 1
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        backgroundColor = UIColor.clear
        clipsToBounds = true
        isUserInteractionEnabled = false
        
        let viewBase:UIView = UIView()
        viewBase.isUserInteractionEnabled = false
        viewBase.translatesAutoresizingMaskIntoConstraints = false
        viewBase.clipsToBounds = true
        viewBase.layer.cornerRadius = kCornerRadius
        viewBase.layer.borderWidth = kBorderWidth
        viewBase.layer.borderColor = UIColor(
            white:0, alpha:0.1).cgColor
        
        addSubview(viewBase)
        
        NSLayoutConstraint.topToTop(
            view:viewBase,
            toView:self,
            constant:kBaseMargin)
        NSLayoutConstraint.bottomToBottom(
            view:viewBase,
            toView:self,
            constant:kBaseBottom)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBase,
            toView:self,
            margin:kBaseMargin)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: internal
    
    func config(model:MConnectedEventProtocol)
    {
    }
}
