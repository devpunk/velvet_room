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
        
        super.layoutIfNeeded()
    }
    
    override func scrollViewDidScroll(
        _ scrollView:UIScrollView)
    {
        updateScroll()
    }
    
    //MARK: private
    
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
