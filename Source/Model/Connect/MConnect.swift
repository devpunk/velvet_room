import UIKit

final class MConnect:Model<ArchConnect>
{
    let itemsWalk:[MConnectWalkProtocol]

    required init()
    {
        itemsWalk = MConnect.factoryWalk()
        
        super.init()
    }
}
