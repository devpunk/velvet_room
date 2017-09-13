import UIKit

final class VConnectingPinList:VCollection<
    ArchConnecting,
    VConnectingPinListCell>
{
    private var cellSize:CGSize?
    private let kInterItem:CGFloat = 5
    private let kCellWidth:CGFloat = 30
    
    required init(controller:CConnecting)
    {
        super.init(controller:controller)
        isUserInteractionEnabled = false
        
        collectionView.isUserInteractionEnabled = false
        collectionView.bounces = false
        collectionView.isScrollEnabled = false
        
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
        guard
            
            let countCells:Int = controller.model.modelPin?.length
        
        else
        {
            return UIEdgeInsets.zero
        }
        
        let countCellsFloat:CGFloat = CGFloat(countCells)
        let width:CGFloat = collectionView.bounds.width
        let widthCells:CGFloat = kCellWidth * countCellsFloat
        let interSpaces:CGFloat = countCellsFloat - 1
        let widthInterSpaces:CGFloat = interSpaces * kInterItem
        let usedSpace:CGFloat = widthCells + widthInterSpaces
        let remainWidth:CGFloat = width - usedSpace
        let margin:CGFloat = remainWidth / 2.0
        let insets:UIEdgeInsets = UIEdgeInsets(
            top:0,
            left:margin,
            bottom:0,
            right:margin)
        
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
            let cellSize:CGSize = CGSize(
                width:kCellWidth,
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
        guard
        
            let count:Int = controller.model.modelPin?.length
        
        else
        {
            return 0
        }
        
        return count
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:String = modelAtIndex(index:indexPath)
        let cell:VConnectingPinListCell = cellAtIndex(
            indexPath:indexPath)
        cell.config(number:item)
        
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
    
    private func modelAtIndex(index:IndexPath) -> String
    {
        let item:String = controller.model.modelPin!.digitAtIndex(
            index:index.item)
        
        return item
    }
}
