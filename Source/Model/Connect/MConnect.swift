import UIKit

final class MConnect:Model<ArchConnect>
{
    private(set) var status:MConnectStatusProtocol?

    required init()
    {
        super.init()
        statusStandby()
    }
    
    //MARK: internal
    
    func statusStandby()
    {
        status = MConnectStatusStandby(model:self)
    }
    
    func statusConnected()
    {
        status = MConnectStatusConnected(model:self)
    }
}
