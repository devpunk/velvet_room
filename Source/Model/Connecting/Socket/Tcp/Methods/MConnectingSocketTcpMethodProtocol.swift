import Foundation

protocol MConnectingSocketTcpMethodProtocol
{
    var type:MConnectingSocketTcpMethodType { get }
    
    init(received:String)
    func strategy(model:MConnectingSocketTcp)
}
