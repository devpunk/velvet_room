import Foundation
import CocoaAsyncSocket

final class MConnectingSocketTcp
{
    let originalSocket:GCDAsyncSocket
    private(set) weak var model:MConnectingSocket?
    private(set) var acceptedSocket:GCDAsyncSocket?
    private let delegate:MConnectingSocketTcpDelegate
    private let queue:DispatchQueue
    
    init(
        model:MConnectingSocket,
        socket:GCDAsyncSocket,
        delegate:MConnectingSocketTcpDelegate,
        queue:DispatchQueue)
    {
        self.model = model
        self.originalSocket = socket
        self.delegate = delegate
        self.queue = queue
    }

    //MARK: internal
    
    func cancel()
    {
        originalSocket.delegate = nil
        originalSocket.disconnect()
        
        acceptedSocket?.delegate = nil
        acceptedSocket?.disconnect()
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
    
    func acceptedConnection(acceptedSocket:GCDAsyncSocket)
    {
        self.acceptedSocket = acceptedSocket
        model?.model?.vitaFound()
        
        DispatchQueue.global(
            qos:DispatchQoS.QoSClass.background).async
        {
            acceptedSocket.readData(withTimeout:0, tag:0)
        }
    }
}
