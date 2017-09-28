import UIKit

final class VConnectedErrorBar:View<ArchConnected>
{
    private let kContentTop:CGFloat = 20
    
    required init(controller:CConnected)
    {
        super.init(controller:controller)
        isUserInteractionEnabled = false
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.contentMode = UIViewContentMode.center
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "assetConnectError")
        addSubview(imageView)
        
        NSLayoutConstraint.topToTop(
            view:imageView,
            toView:self,
            constant:kContentTop)
        NSLayoutConstraint.bottomToBottom(
            view:imageView,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:imageView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
