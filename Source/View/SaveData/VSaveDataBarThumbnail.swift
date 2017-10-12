import UIKit

final class VSaveDataBarThumbnail:View<ArchSaveData>
{
    private weak var imageView:UIImageView!
    private let kBorder:CGFloat = 2
    
    required init(controller:CSaveData)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.black
        isUserInteractionEnabled = false
        
        factoryViews()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        let imageWidth:CGFloat = imageView.bounds.width
        let imageWidth_2:CGFloat = imageWidth / 2.0
        imageView.layer.cornerRadius = imageWidth_2
    }
    
    //MARK: private
    
    private func factoryViews()
    {
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = controller.model.item?.thumbnail
        self.imageView = imageView
        
        addSubview(imageView)
        
        NSLayoutConstraint.equals(
            view:imageView,
            toView:self,
            margin:kBorder)
    }
}
