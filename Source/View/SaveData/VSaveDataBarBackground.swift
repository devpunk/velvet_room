import UIKit

final class VSaveDataBarBackground:View<ArchSaveData>
{
    required init(controller:CSaveData)
    {
        super.init(controller:controller)
        isUserInteractionEnabled = false
        
        factoryViews()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
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
        
        addSubview(imageView)
        
        NSLayoutConstraint.equals(
            view:imageView,
            toView:self)
    }
}
