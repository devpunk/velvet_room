import UIKit

final class VSaveData:ViewMain
{
    private(set) weak var viewBar:VSaveDataBar!
    private weak var viewList:VSaveDataList!
    
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
    
    //MARK: private
    
    private func factoryViews(controller:CSaveData)
    {
        let viewList:VSaveDataList = VSaveDataList(
            controller:controller)
        self.viewList = viewList
        
        let viewBar:VSaveDataBar = VSaveDataBar(
            controller:controller)
        self.viewBar = viewBar
        
        addSubview(viewBar)
        addSubview(viewList)
        
        NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        viewBar.layoutHeight = NSLayoutConstraint.height(
            view:viewBar,
            constant:viewList.kMinBarHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:viewList,
            toView:self)
    }
}
