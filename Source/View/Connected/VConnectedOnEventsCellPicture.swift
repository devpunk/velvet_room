import UIKit

final class VConnectedOnEventsCellPicture:VConnectedOnEventsCell
{
    private weak var imageView:UIImageView!
    private let attributesTitle:[NSAttributedStringKey:Any]
    private let attributesDescr:[NSAttributedStringKey:Any]
    private let kBaseMargin:CGFloat = 1
    private let kCornerRadius:CGFloat = 7
    private let kBorderWidth:CGFloat = 1
    private let kTitleFontSize:CGFloat = 16
    private let kDescrFontSize:CGFloat = 16
    
    override init(frame:CGRect)
    {
        attributesTitle = [
            NSAttributedStringKey.foregroundColor:
                UIColor.colourBackgroundDark,
            NSAttributedStringKey.font:
                UIFont.medium(size:kTitleFontSize)]
        
        attributesDescr = [
            NSAttributedStringKey.foregroundColor:
                UIColor(white:0.4, alpha:1),
            NSAttributedStringKey.font:
                UIFont.regular(size:kDescrFontSize)]
        
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
        
        let attributedString:NSAttributedString = factoryString(
            model:model)
        
        imageView.image = model.picture
        configText(string:attributedString)
    }
    
    //MARK: private
    
    private func factoryString(model:MConnectedEventPicture) -> NSAttributedString
    {
        let stringTitle:NSAttributedString = NSAttributedString(
            string:model.title,
            attributes:attributesTitle)
        let stringDescr:NSAttributedString = NSAttributedString(
            string:model.descr,
            attributes:attributesDescr)
        let stringTimestamp:NSAttributedString = NSAttributedString(
            string:model.timestamp,
            attributes:attributesTimestamp)
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        mutableString.append(stringTitle)
        mutableString.append(lineBreak)
        mutableString.append(stringDescr)
        mutableString.append(lineBreak)
        mutableString.append(stringTimestamp)
        
        return mutableString
    }
}
