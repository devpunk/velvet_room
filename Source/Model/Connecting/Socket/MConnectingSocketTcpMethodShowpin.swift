import Foundation

final class MConnectingSocketTcpMethodShowpin:MConnectingSocketTcpMethodProtocol
{
    let type:MConnectingSocketTcpMethodType = MConnectingSocketTcpMethodType.showpin
    
    init(received:String)
    {
    }
    
    //MARK: internal
    
    func strategy(model:MConnectingSocketTcp)
    {
        model.strategyShowpin()
    }
}
