import UIKit

final class VConnectStandbyWalkCell:UICollectionViewCell
{
    private weak var imageView:UIImageView!
    private weak var labelTitle:UILabel!
    private weak var labelSubtitle:UILabel!
    private let kIconTop:CGFloat = 20
    private let kIconHeight:CGFloat = 200
    
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
        
        addSubview(imageView)
        
        NSLayoutConstraint.topToTop(
            view:imageView,
            toView:self,
            constant:kIconTop)
        NSLayoutConstraint.height(
            view:imageView,
            constant:kIconHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:imageView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: internal
    
    func config(model:MConnectWalkProtocol)
    {
        imageView.image = model.icon
    }
}
