import UIKit

final class MConnect:Model<ArchConnect>
{
    let itemsWalk:[MConnectWalkProtocol]
    var status:MConnectStatusProtocol?

    required init()
    {
        itemsWalk = MConnect.factoryWalk()
        
        super.init()
        statusStandby()
    }
}
