import UIKit

final class VSaveData:ViewMain
{
    private(set) weak var viewBar:VSaveDataBar!
    private weak var viewList:VSaveDataList!
    private weak var viewBack:VSaveDataBarBack!
    
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
        super.layoutSubviews()
        
        let barHeight:CGFloat = viewBar.bounds.height
        let backRemainHeight:CGFloat = barHeight - viewBack.kHeight
        let backMarginBottom:CGFloat = backRemainHeight / -2.0
        viewBack.layoutBottom.constant = backMarginBottom
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
        
        let viewBack:VSaveDataBarBack = VSaveDataBarBack(
            controller:controller)
        self.viewBack = viewBack
        
        addSubview(viewBar)
        addSubview(viewList)
        addSubview(viewBack)
        
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
        
        viewBack.layoutBottom = NSLayoutConstraint.bottomToBottom(
            view:viewBack,
            toView:viewBar)
        NSLayoutConstraint.height(
            view:viewBack,
            constant:viewBack.kHeight)
        NSLayoutConstraint.width(
            view:viewBack,
            constant:viewBack.kWidth)
        NSLayoutConstraint.leftToLeft(
            view:viewBack,
            toView:self)
    }
}
