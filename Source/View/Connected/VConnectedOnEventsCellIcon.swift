import UIKit

final class VConnectedOnEventsCellIcon:VConnectedOnEventsCell
{
    private weak var imageView:UIImageView!
    
    override init(frame:CGRect)
    {
        let imageViewHeight:CGFloat = frame.width
        
        super.init(frame:frame)
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        self.imageView = imageView
        
        addSubview(imageView)
        
        NSLayoutConstraint.topToTop(
            view:imageView,
            toView:self)
        NSLayoutConstraint.height(
            view:imageView,
            constant:imageViewHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:imageView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func config(model:MConnectedEventProtocol)
    {
        guard
        
            let model:MConnectedEventIcon = model as? MConnectedEventIcon
        
        else
        {
            return
        }
        
        imageView.image = model.icon
    }
}
