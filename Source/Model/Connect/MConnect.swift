import UIKit

final class MConnect:Model<ArchConnect>
{
    let itemsWalk:[MConnectWalkProtocol]
    private(set) var status:MConnectStatusProtocol?

    required init()
    {
        itemsWalk = MConnect.factoryWalk()
        
        super.init()
        statusStandby()
    }
    
    //MARK: internal
    
    func statusStandby()
    {
        status = MConnectStatusStandby()
    }
    
    func statusLoading()
    {
        status = MConnectStatusLoading()
    }
    
    func statusConnected()
    {
        status = MConnectStatusConnected()
    }
}
