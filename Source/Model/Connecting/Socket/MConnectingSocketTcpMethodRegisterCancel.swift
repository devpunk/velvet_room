import Foundation

final class MConnectingSocketTcpMethodRegisterCancel:MConnectingSocketTcpMethodProtocol
{
    let type:MConnectingSocketTcpMethodType = MConnectingSocketTcpMethodType.registerCancel
    
    init(received:String)
    {
    }
    
    //MARK: internal
    
    func strategy(model:MConnectingSocketTcp)
    {
    }
}
