import Foundation

final class MConnectingSocketTcpMethodConnect:MConnectingSocketTcpMethodProtocol
{
    let type:MConnectingSocketTcpMethodType = MConnectingSocketTcpMethodType.connect
    
    init(received:String)
    {
    }
    
    //MARK: internal
    
    func strategy(model:MConnectingSocketTcp)
    {
    }
}
