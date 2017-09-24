import UIKit

final class VConnectedOnEvents:VCollection<
    ArchConnected,
    VConnectedOnEventsCell>
{
    private var currentItems:Int
    
    required init(controller:CConnected)
    {
        currentItems = controller.model.events.count
        
        super.init(controller:controller)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
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
