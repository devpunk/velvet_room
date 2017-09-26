import UIKit

final class VConnectedOnEventsCellPicture:VConnectedOnEventsCell
{
    private weak var imageView:UIImageView!
    private let kBaseMargin:CGFloat = 1
    private let kCornerRadius:CGFloat = 7
    private let kBorderWidth:CGFloat = 1
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        isUserInteractionEnabled = false
        
        let baseMargin2:CGFloat = kBaseMargin + kBaseMargin
        let viewBaseHeight:CGFloat = frame.width - baseMargin2
        let viewBase:UIView = UIView()
        viewBase.isUserInteractionEnabled = false
        viewBase.translatesAutoresizingMaskIntoConstraints = false
        viewBase.clipsToBounds = true
        viewBase.layer.cornerRadius = kCornerRadius
        viewBase.layer.borderWidth = kBorderWidth
        viewBase.layer.borderColor = UIColor.black.cgColor
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        self.imageView = imageView
        
        viewBase.addSubview(imageView)
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
        
        NSLayoutConstraint.equals(
            view:imageView,
            toView:viewBase)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func config(model:MConnectedEventProtocol)
    {
        guard
        
            let model:MConnectedEventPicture = model as? MConnectedEventPicture
        
        else
        {
            return
        }
        
        imageView.image = model.picture
    }
}
