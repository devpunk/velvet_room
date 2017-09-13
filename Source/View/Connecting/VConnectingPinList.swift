import UIKit

final class VConnectingPinList:VCollection<
    ArchConnecting,
    VConnectingPinListCell>
{
    private let kInterItem:CGFloat = 5
    
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
}
