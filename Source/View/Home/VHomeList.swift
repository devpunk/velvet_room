import UIKit

final class VHomeList:VCollection<
    ArchHome,
    VHomeListCell>
{
    private let kInsetsTop:CGFloat = 64
    private let kInsetsBottom:CGFloat = 60
    private let kInterItemSpace:CGFloat = 1
    
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
}
