import UIKit

class VConnectingPinListCell:UICollectionViewCell
{
    private weak var labelNumber:UILabel!
    private let kCornerRadius:CGFloat = 6
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        isUserInteractionEnabled = false
        
        let background:UIView = UIView()
        background.isUserInteractionEnabled = false
        background.backgroundColor = UIColor(white:1, alpha:0.8)
        background.translatesAutoresizingMaskIntoConstraints = false
        background.layer.cornerRadius = kCornerRadius
        
        let labelNumber:UILabel = UILabel()
        labelNumber.isUserInteractionEnabled = false
        labelNumber.translatesAutoresizingMaskIntoConstraints = false
        labelNumber.backgroundColor = UIColor.clear
        labelNumber.font = UIFont.bold(size:25)
        labelNumber.textColor = UIColor.black
        labelNumber.textAlignment = NSTextAlignment.center
        self.labelNumber = labelNumber
        
        addSubview(background)
        addSubview(labelNumber)
        
        NSLayoutConstraint.equals(
            view:background,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:labelNumber,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: internal
    
    func config(number:String)
    {
        labelNumber.text = number
    }
}
