import Foundation

final class MConnectingSocketTcpMethodStandby:MConnectingSocketTcpMethodProtocol
{
    let type:MConnectingSocketTcpMethodType = MConnectingSocketTcpMethodType.standby
    
    init(received:String)
    {
    }
    
    //MARK: internal
    
    func strategy(model:MConnectingSocketTcp)
    {
    }
}
