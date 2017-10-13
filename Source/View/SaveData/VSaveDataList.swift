import UIKit

final class VSaveDataList:VCollection<
    ArchSaveData,
    VSaveDataListCell>
{
    let kHeightRatio:CGFloat = 0.6
    let kMinBarHeight:CGFloat = 20
    private var insetsTop:CGFloat
    private let kInsetsBottom:CGFloat = 80
    private let kScrollMultiplier:CGFloat = -0.5
    
    required init(controller:CSaveData)
    {
        insetsTop = 0
        
        super.init(controller:controller)
        collectionView.alwaysBounceVertical = true
        registerCell(cell:VSaveDataListCellTitle.self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.width
        insetsTop = width * kHeightRatio
        updateFlow()
        updateScroll()
        
        super.layoutIfNeeded()
    }
    
    override func scrollViewDidScroll(
        _ scrollView:UIScrollView)
    {
        updateScroll()
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        layout collectionViewLayout:UICollectionViewLayout,
        sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let item:MSaveDataProtocol = modelAtIndex(index:indexPath)
        let width:CGFloat = collectionView.bounds.width
        let size:CGSize = CGSize(
            width:width,
            height:item.height)
        
        return size
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.model.content.count
        
        return count
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MSaveDataProtocol = modelAtIndex(index:indexPath)
        let cell:VSaveDataListCell = cellAtIndex(
            reusableIdentifier:item.reusableIdentifier,
            indexPath:indexPath)
        cell.config(
            controller:controller,
            model:item)
        
        return cell
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MSaveDataProtocol
    {
        let item:MSaveDataProtocol = controller.model.content[
            index.item]
        
        return item
    }
    
    private func updateFlow()
    {
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.sectionInset = UIEdgeInsets(
                top:insetsTop,
                left:0,
                bottom:kInsetsBottom,
                right:0)
        }
    }
    
    private func updateScroll()
    {
        let offsetY:CGFloat = collectionView.contentOffset.y
        let offsetMultiplied:CGFloat = offsetY * kScrollMultiplier
        var barHeight:CGFloat = insetsTop + offsetMultiplied
        
        if barHeight < kMinBarHeight
        {
            barHeight = kMinBarHeight
        }
        
        controller.model.view?.viewBar.layoutHeight.constant = barHeight
    }
}
