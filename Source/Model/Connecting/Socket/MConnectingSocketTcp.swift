import Foundation
import CocoaAsyncSocket

final class MConnectingSocketTcp
{
    private(set) weak var model:MConnectingSocket?
    private let socket:GCDAsyncSocket
    private let delegate:MConnectingSocketTcpDelegate
    private let queue:DispatchQueue
    
    init(
        model:MConnectingSocket,
        socket:GCDAsyncSocket,
        delegate:MConnectingSocketTcpDelegate,
        queue:DispatchQueue)
    {
        self.model = model
        self.socket = socket
        self.delegate = delegate
        self.queue = queue
    }
    
    //MARK: internal
    
    func cancel()
    {
        socket.delegate = nil
        socket.disconnect()
    }
    
    func receivedString(string:String)
    {
        guard
        
            let method:MConnectingSocketTcpMethodProtocol = MConnectingSocketTcpMethodType.factoryMethod(
                string:string)
        
        else
        {
            return
        }
        
        method.strategy(model:self)
    }
}
