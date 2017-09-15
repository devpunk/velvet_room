import Foundation

final class MConnectingSocketTcpMethodRegister:MConnectingSocketTcpMethodProtocol
{
    let type:MConnectingSocketTcpMethodType = MConnectingSocketTcpMethodType.register
    
    init(received:String)
    {
    }
    
    func strategy(model:MConnectingSocketTcp)
    {
    }
}
