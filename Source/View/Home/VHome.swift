import UIKit

final class VHome:ViewMain
{
    private let kBarHeight:CGFloat = 64
    private weak var viewList:VHomeList!
    
    required init(controller:UIViewController)
    {
        super.init(controller:controller)
        
        guard
        
            let controller:CHome = controller as? CHome
        
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
    
    private func factoryViews(controller:CHome)
    {
        let viewBar:VHomeBar = VHomeBar(
            controller:controller)
        
        let viewList:VHomeList = VHomeList(
            controller:controller)
        self.viewList = viewList
        
        addSubview(viewList)
        addSubview(viewBar)
        
        NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        NSLayoutConstraint.height(
            view:viewBar,
            constant:kBarHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:viewList,
            toView:self)
    }
    
    private func asyncRefresh()
    {
        viewList.collectionView.reloadData()
    }
    
    //MARK: internal
    
    func refresh()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.asyncRefresh()
        }
    }
}
