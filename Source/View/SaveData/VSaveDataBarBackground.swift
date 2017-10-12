import UIKit

final class VSaveDataBarBackground:View<ArchSaveData>
{
    private let kBlurAlpha:CGFloat = 0.96
    
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
    
    //MARK: private
    
    private func factoryViews()
    {
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = controller.model.item?.thumbnail
        
        let blurBase:UIView = UIView()
        blurBase.isUserInteractionEnabled = false
        blurBase.clipsToBounds = true
        blurBase.translatesAutoresizingMaskIntoConstraints = false
        blurBase.alpha = kBlurAlpha
        
        let blur:VBlur = VBlur.dark()
        
        blurBase.addSubview(blur)
        addSubview(imageView)
        addSubview(blurBase)
        
        NSLayoutConstraint.equals(
            view:imageView,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:blurBase,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
    }
}
