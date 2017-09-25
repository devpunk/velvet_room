import UIKit

final class VConnectedOnEvents:VCollection<
    ArchConnected,
    VConnectedOnEventsCell>
{
    private var currentItems:Int
    private let kCellWidth:CGFloat = 160
    private let kCellHeight:CGFloat = 190
    private let kInterItem:CGFloat = 10
    private let kInsetsTop:CGFloat = 150
    
    required init(controller:CConnected)
    {
        currentItems = controller.model.events.count
        
        super.init(controller:controller)
        
        collectionView.alwaysBounceHorizontal = true
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.scrollDirection = UICollectionViewScrollDirection.horizontal
            flow.minimumInteritemSpacing = kInterItem
            flow.minimumLineSpacing = kInterItem
            flow.itemSize = CGSize(
                width:kCellWidth,
                height:kCellHeight)
        }
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        layout collectionViewLayout:UICollectionViewLayout,
        insetForSectionAt section:Int) -> UIEdgeInsets
    {
        let width:CGFloat = collectionView.bounds.width
        let height:CGFloat = collectionView.bounds.height
        let remainWidth:CGFloat = width - kCellWidth
        let marginHorizontal:CGFloat = remainWidth / 2.0
        let usedHeight:CGFloat = kInsetsTop + kCellHeight
        let marginBottom:CGFloat = height - usedHeight
        let insets:UIEdgeInsets = UIEdgeInsets(
            top:kInsetsTop,
            left:marginHorizontal,
            bottom:marginBottom,
            right:marginHorizontal)
        
        return insets
    }
    
    //MARK: private
    
    private func factoryIndexPaths(endingIndex:Int) -> [IndexPath]
    {
        var indexPaths:[IndexPath] = []
        
        for index:Int in currentItems ..< endingIndex
        {
            let indexPath:IndexPath = IndexPath(
                item:index,
                section:0)
            indexPaths.append(indexPath)
        }
        
        return indexPaths
    }
    
    private func addItems(
        indexPaths:[IndexPath],
        currentItems:Int)
    {
        self.currentItems = currentItems
        collectionView.insertItems(at:indexPaths)
        
        guard
        
            let lastItem:IndexPath = indexPaths.last
        
        else
        {
            return
        }
        
        collectionView.scrollToItem(
            at:lastItem,
            at:UICollectionViewScrollPosition.centeredHorizontally,
            animated:true)
    }
    
    //MARK: internal
    
    func update()
    {
        let items:Int = controller.model.events.count
        let newItems:Int = items - currentItems
        
        guard
            
            newItems > 0
            
        else
        {
            return
        }
        
        let endingIndex:Int = currentItems + newItems
        let indexPaths:[IndexPath] = factoryIndexPaths(
            endingIndex:endingIndex)
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.addItems(
                indexPaths:indexPaths,
                currentItems:endingIndex)
        }
    }
}
