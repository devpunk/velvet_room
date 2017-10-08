import UIKit

final class VHomeList:VCollection<
    ArchHome,
    VHomeListCell>
{
    private var cellSize:CGSize?
    private let kInsetsTop:CGFloat = 64
    private let kInsetsBottom:CGFloat = 60
    private let kInterItemSpace:CGFloat = 1
    private let kCellHeight:CGFloat = 90
    
    required init(controller:CHome)
    {
        super.init(controller:controller)
        
        collectionView.alwaysBounceVertical = true
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.minimumLineSpacing = kInterItemSpace
            flow.minimumInteritemSpacing = kInterItemSpace
            flow.sectionInset = UIEdgeInsets(
                top:kInsetsTop,
                left:0,
                bottom:kInsetsBottom,
                right:0)
        }
    }
    
    required init?(coder:NSCoder)
    {
        return nil
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
            let cellSize:CGSize = CGSize(
                width:width,
                height:kCellHeight)
            self.cellSize = cellSize
            
            return cellSize
        }
        
        return cellSize
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.model.saveDataItems.count
        
        return count
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MHomeSaveDataItem = modelAtIndex(index:indexPath)
        let cell:VHomeListCell = cellAtIndex(indexPath:indexPath)
        cell.config(model:item)
        
        return cell
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MHomeSaveDataItem
    {
        let item:MHomeSaveDataItem = controller.model.saveDataItems[
            index.item]
        
        return item
    }
}
