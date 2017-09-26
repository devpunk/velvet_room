import UIKit

final class VConnectedOnEvents:VCollection<
    ArchConnected,
    VConnectedOnEventsCell>
{
    private var cellSize:CGSize?
    private var currentItems:Int
    private let kCellWidth:CGFloat = 200
    private let kInterItem:CGFloat = 10
    private let kInsetsTop:CGFloat = 100
    
    required init(controller:CConnected)
    {
        currentItems = controller.model.events.count
        
        super.init(controller:controller)
        collectionView.alwaysBounceHorizontal = true
        registerCell(cell:VConnectedOnEventsCellIcon.self)
        registerCell(cell:VConnectedOnEventsCellPicture.self)
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.scrollDirection = UICollectionViewScrollDirection.horizontal
            flow.minimumInteritemSpacing = kInterItem
            flow.minimumLineSpacing = kInterItem
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
        let remainWidth:CGFloat = width - kCellWidth
        let marginHorizontal:CGFloat = remainWidth / 2.0
        let insets:UIEdgeInsets = UIEdgeInsets(
            top:kInsetsTop,
            left:marginHorizontal,
            bottom:0,
            right:marginHorizontal)
        
        return insets
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
            let height:CGFloat = collectionView.bounds.height
            let cellHeight:CGFloat = height - kInsetsTop
            let cellSize:CGSize = CGSize(
                width:kCellWidth,
                height:cellHeight)
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
        return currentItems
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MConnectedEventProtocol = modelAtIndex(index:indexPath)
        let cell:VConnectedOnEventsCell = cellAtIndex(
            reusableIdentifier:item.reusableIdentifier,
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
    
    private func modelAtIndex(index:IndexPath) -> MConnectedEventProtocol
    {
        let item:MConnectedEventProtocol = controller.model.events[
            index.item]
        
        return item
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
