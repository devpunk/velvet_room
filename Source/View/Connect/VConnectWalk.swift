import UIKit

final class VConnectWalk:VCollection<
    ArchConnect,
    VConnectWalkCell>
{
    private weak var viewPage:UIPageControl!
    private var cellSize:CGSize?
    private let kPageBottom:CGFloat = -170
    
    required init(controller:CConnect)
    {
        super.init(controller:controller)
        collectionView.isPagingEnabled = true
        collectionView.alwaysBounceHorizontal = true
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.scrollDirection = UICollectionViewScrollDirection.horizontal
        }
        
        factoryPages()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func scrollViewDidEndDecelerating(
        _ scrollView:UIScrollView)
    {
        updatePage()
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        layout collectionViewLayout:UICollectionViewLayout,
        sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        guard
            
            let cellSize:CGSize = self.cellSize
            
        else
        {
            let width:CGFloat = collectionView.bounds.width
            let height:CGFloat = collectionView.bounds.height
            let cellSize:CGSize = CGSize(
                width:width,
                height:height)
            self.cellSize = cellSize
            
            return cellSize
        }
        
        return cellSize
    }
    
    override func numberOfSections(
        in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.model.itemsWalk.count
        
        return count
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MConnectWalkProtocol = modelAtIndex(
            index:indexPath)
        let cell:VConnectWalkCell = cellAtIndex(
            indexPath:indexPath)
        cell.config(model:item)
        
        return cell
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        shouldSelectItemAt indexPath:IndexPath) -> Bool
    {
        return false
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        shouldHighlightItemAt indexPath:IndexPath) -> Bool
    {
        return false
    }
    
    //MARK: private
    
    private func factoryPages()
    {
        let pages:Int = controller.model.itemsWalk.count
        
        let viewPage:UIPageControl = UIPageControl()
        viewPage.isUserInteractionEnabled = false
        viewPage.translatesAutoresizingMaskIntoConstraints = false
        viewPage.numberOfPages = pages
        viewPage.currentPageIndicatorTintColor = UIColor(
            red:1,
            green:0.23529411764705888,
            blue:0.3686274509803924,
            alpha:1)
        viewPage.pageIndicatorTintColor = UIColor.colourBackgroundGray
        self.viewPage = viewPage
        
        if pages > 0
        {
            viewPage.currentPage = 0
        }
        
        addSubview(viewPage)
        
        NSLayoutConstraint.bottomToBottom(
            view:viewPage,
            toView:self,
            constant:kPageBottom)
        NSLayoutConstraint.equalsHorizontal(
            view:viewPage,
            toView:self)
    }
    
    private func modelAtIndex(index:IndexPath) -> MConnectWalkProtocol
    {
        let item:MConnectWalkProtocol = controller.model.itemsWalk[
            index.item]
        
        return item
    }
    
    private func updatePage()
    {
        let offset:CGFloat = collectionView.contentOffset.x
        let width_2:CGFloat = bounds.midX
        let height_2:CGFloat = bounds.midY
        let midPoint:CGPoint = CGPoint(
            x:width_2 + offset,
            y:height_2)
        
        guard
            
            let index:IndexPath = collectionView.indexPathForItem(
                at:midPoint)
            
            else
        {
            return
        }
        
        viewPage.currentPage = index.item
    }
}
