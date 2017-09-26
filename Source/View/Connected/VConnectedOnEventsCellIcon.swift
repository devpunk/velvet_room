import UIKit

final class VConnectedOnEventsCellIcon:VConnectedOnEventsCell
{
    private weak var imageView:UIImageView!
    private let attributesTitle:[NSAttributedStringKey:Any]
    private let kTitleFontSize:CGFloat = 14
    
    override init(frame:CGRect)
    {
        attributesTitle = [
            NSAttributedStringKey.foregroundColor:
                UIColor.colourBackgroundDark,
            NSAttributedStringKey.font:
                UIFont.medium(size:kTitleFontSize)]
        
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
        
        let attributedString:NSAttributedString = factoryString(
            model:model)
        
        imageView.image = model.icon
        configText(string:attributedString)
    }
    
    //MARK: private
    
    private func factoryString(model:MConnectedEventIcon) -> NSAttributedString
    {
        let stringTitle:NSAttributedString = NSAttributedString(
            string:model.title,
            attributes:attributesTitle)
        let stringTimestamp:NSAttributedString = NSAttributedString(
            string:model.timestamp,
            attributes:attributesTimestamp)
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        mutableString.append(stringTitle)
        mutableString.append(lineBreak)
        mutableString.append(stringTimestamp)
        
        return mutableString
    }
}
