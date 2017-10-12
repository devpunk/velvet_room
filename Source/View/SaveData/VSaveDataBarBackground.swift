import UIKit

final class VSaveDataBarBackground:View<ArchSaveData>
{
    private let kBlurAlpha:CGFloat = 0.96
    private let kMarginBottom:CGFloat = -5
    
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
        imageView.contentMode = UIViewContentMode.scaleAspectFill
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
        
        NSLayoutConstraint.topToTop(
            view:imageView,
            toView:self)
        NSLayoutConstraint.bottomToBottom(
            view:imageView,
            toView:self,
            constant:kMarginBottom)
        NSLayoutConstraint.equalsHorizontal(
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
