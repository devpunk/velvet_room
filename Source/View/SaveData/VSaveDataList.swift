import UIKit

final class VSaveDataList:VCollection<
    ArchSaveData,
    VSaveDataListCell>
{
    let kHeightRatio:CGFloat = 0.62
    private let kInsetsBottom:CGFloat = 80
    
    required init(controller:CSaveData)
    {
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
        let insetsTop:CGFloat = width * kHeightRatio
        updateFlow(insetsTop:insetsTop)
        
        super.layoutIfNeeded()
    }
    
    //MARK: private
    
    private func updateFlow(insetsTop:CGFloat)
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
}
