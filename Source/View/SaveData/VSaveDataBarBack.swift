import UIKit

final class VSaveDataBarBack:View<ArchSaveData>
{
    weak var layoutTop:NSLayoutConstraint!
    let kWidth:CGFloat = 80
    let kHeight:CGFloat = 50
    
    required init(controller:CSaveData)
    {
        super.init(controller:controller)
        factoryViews()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: selectors
    
    @objc
    private func selectorBack(sender button:UIButton)
    {
        controller.back()
    }
    
    //MARK: private
    
    private func factoryViews()
    {
        let button:UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(
            #imageLiteral(resourceName: "assetGenericBack"),
            for:UIControlState.normal)
        button.imageView!.clipsToBounds = true
        button.imageView!.contentMode = UIViewContentMode.center
        button.addTarget(
            self,
            action:#selector(selectorBack(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(button)
        
        NSLayoutConstraint.equals(
            view:button,
            toView:self)
    }
}
