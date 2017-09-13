import UIKit

final class VConnectWalkCell:UICollectionViewCell
{
    private weak var imageView:UIImageView!
    private weak var labelTitle:UILabel!
    private weak var labelDescr:UILabel!
    private let kIconHeightRatio:CGFloat = 0.7
    private let kDescrBottom:CGFloat = -210
    private let kDescrHeight:CGFloat = 70
    private let kTitleHeight:CGFloat = 24
    private let kLabelMarginHorizontal:CGFloat = 20
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        isUserInteractionEnabled = false
        backgroundColor = UIColor.clear
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.center
        imageView.clipsToBounds = true
        self.imageView = imageView
        
        let labelTitle:UILabel = UILabel()
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.isUserInteractionEnabled = false
        labelTitle.font = UIFont.medium(size:17)
        labelTitle.textColor = UIColor.colourBackgroundDark
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.textAlignment = NSTextAlignment.center
        self.labelTitle = labelTitle
        
        let labelDescr:UILabel = UILabel()
        labelDescr.translatesAutoresizingMaskIntoConstraints = false
        labelDescr.isUserInteractionEnabled = false
        labelDescr.font = UIFont.regular(size:14)
        labelDescr.textColor = UIColor.colourBackgroundDark.withAlphaComponent(0.4)
        labelDescr.backgroundColor = UIColor.clear
        labelDescr.textAlignment = NSTextAlignment.center
        labelDescr.numberOfLines = 0
        self.labelDescr = labelDescr
        
        addSubview(imageView)
        addSubview(labelTitle)
        addSubview(labelDescr)
        
        NSLayoutConstraint.topToTop(
            view:imageView,
            toView:self)
        NSLayoutConstraint.height(
            view:imageView,
            toView:self,
            multiplier:kIconHeightRatio)
        NSLayoutConstraint.equalsHorizontal(
            view:imageView,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:labelDescr,
            toView:self,
            constant:kDescrBottom)
        NSLayoutConstraint.height(
            view:labelDescr,
            constant:kDescrHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelDescr,
            toView:self,
            margin:kLabelMarginHorizontal)
        
        NSLayoutConstraint.bottomToTop(
            view:labelTitle,
            toView:labelDescr)
        NSLayoutConstraint.height(
            view:labelTitle,
            constant:kTitleHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelTitle,
            toView:self,
            margin:kLabelMarginHorizontal)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: internal
    
    func config(model:MConnectWalkProtocol)
    {
        imageView.image = model.icon
        labelTitle.text = model.title
        labelDescr.text = model.descr
    }
}

