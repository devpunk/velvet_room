import UIKit

class VConnectingPinListCell:UICollectionViewCell
{
    private let kCornerRadius:CGFloat = 6
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        isUserInteractionEnabled = false
        
        let background:UIView = UIView()
        background.isUserInteractionEnabled = false
        background.backgroundColor = UIColor(white:1, alpha:0.6)
        background.translatesAutoresizingMaskIntoConstraints = false
        background.layer.cornerRadius = kCornerRadius
        
        addSubview(background)
        
        NSLayoutConstraint.equals(
            view:background,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
