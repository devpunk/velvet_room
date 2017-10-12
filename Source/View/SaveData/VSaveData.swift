import UIKit

final class VSaveData:ViewMain
{
    private weak var viewList:VSaveDataList!
    private weak var layoutBarHeight:NSLayoutConstraint!
    
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
        let height:CGFloat = width * viewList.kHeightRatio
        layoutBarHeight.constant = height
        
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func factoryViews(controller:CSaveData)
    {
        let viewList:VSaveDataList = VSaveDataList(
            controller:controller)
        self.viewList = viewList
        
        let viewBar:VSaveDataBar = VSaveDataBar(
            controller:controller)
        
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
