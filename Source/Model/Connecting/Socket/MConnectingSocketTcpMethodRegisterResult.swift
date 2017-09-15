import Foundation

final class MConnectingSocketTcpMethodRegisterResult:MConnectingSocketTcpMethodProtocol
{
    let type:MConnectingSocketTcpMethodType = MConnectingSocketTcpMethodType.registerResult
    
    init(received:String)
    {
    }
    
    func strategy(model:MConnectingSocketTcp)
    {
    }
}
