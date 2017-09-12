import UIKit

class VConnectStandbyWalk:VCollection<
    ArchConnect,
    VConnectStandbyWalkCell>
{
    private var cellSize:CGSize?
    
    required init(controller:CConnect)
    {
        super.init(controller:controller)
        collectionView.isPagingEnabled = true
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.scrollDirection = UICollectionViewScrollDirection.horizontal
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
            let height:CGFloat = collectionView.bounds.height
            let cellSize:CGSize = CGSize(
                width:width,
                height:height)
            self.cellSize = cellSize
            
            return cellSize
        }
        
        return cellSize
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let cell:VConnectStandbyWalkCell = cellAtIndex(indexPath:indexPath)
        
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
}
