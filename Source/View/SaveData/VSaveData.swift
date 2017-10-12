import UIKit

final class VSaveData:ViewMain
{
    private weak var layoutBarHeight:NSLayoutConstraint!
    private let kWidthRatio:CGFloat = 0.6
    
    override var panBack:Bool
    {
        get
        {
            return true
        }
    }
    
    required init(controller:UIViewController)
    {
        super.init(controller:controller)
        
        guard
        
            let controller:CSaveData = controller as? CSaveData
        
        else
        {
            return
        }
        
        factoryViews(controller:controller)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.width
        let height:CGFloat = width * kWidthRatio
        layoutBarHeight.constant = height
        
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func factoryViews(controller:CSaveData)
    {
        let viewBar:VSaveDataBar = VSaveDataBar(controller:controller)
        
        addSubview(viewBar)
        
        NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        layoutBarHeight = NSLayoutConstraint.height(
            view:viewBar)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
    }
}
