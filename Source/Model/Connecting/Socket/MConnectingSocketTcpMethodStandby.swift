import Foundation

final class MConnectingSocketTcpMethodStandby:MConnectingSocketTcpMethodProtocol
{
    let type:MConnectingSocketTcpMethodType = MConnectingSocketTcpMethodType.standby
    
    init(received:String)
    {
    }
    
    func strategy(model:MConnectingSocketTcp)
    {
    }
}
