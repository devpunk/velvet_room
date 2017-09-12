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
    
    //MARK: private
    
    private func connect()
    {
        
    }
    
    //MARK: internal
    
    func startConnection()
    {
        guard
        
            let status:MConnectStatusProtocol = self.status,
            status.shouldStart
        
        else
        {
            return
        }
        
        
    }
}
