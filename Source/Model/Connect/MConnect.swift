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
        status = MConnectStatusStandby(model:self)
    }
    
    func statusLoading()
    {
        status = MConnectStatusLoading(model:self)
    }
    
    func statusConnected()
    {
        status = MConnectStatusConnected(model:self)
    }
}
