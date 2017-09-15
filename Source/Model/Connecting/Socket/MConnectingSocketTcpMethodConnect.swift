import Foundation

final class MConnectingSocketTcpMethodConnect:MConnectingSocketTcpMethodProtocol
{
    let type:MConnectingSocketTcpMethodType = MConnectingSocketTcpMethodType.connect
    
    init(received:String)
    {
    }
    
    func strategy(model:MConnectingSocketTcp)
    {
    }
}
