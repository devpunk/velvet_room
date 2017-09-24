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
    
    //MARK: private
    
    private func parseMethod(string:String) -> String?
    {
        guard
            
            let lineSeparator:String = model?.configuration.lineSeparator,
            let methodSeparator:String = model?.configuration.broadcast.methodSeparator
        
        else
        {
            return nil
        }
        
        let components:[String] = string.components(
            separatedBy:lineSeparator)
        
        guard
        
            let first:String = components.first
        
        else
        {
            return nil
        }
        
        let firstComponents:[String] = first.components(
            separatedBy:methodSeparator)
        
        let method:String? = firstComponents.first
        
        return method
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
        
            let methodName:String = parseMethod(
                string:string),
            let method:MConnectingSocketTcpMethodProtocol = MConnectingSocketTcpMethodType.factoryMethod(
                name:methodName,
                received:string)
        
        else
        {
            return
        }
        
        method.strategy(model:self)
    }
    
    func acceptedConnection(acceptedSocket:GCDAsyncSocket)
    {
        self.acceptedSocket = acceptedSocket
        
        DispatchQueue.global(
            qos:DispatchQoS.QoSClass.background).async
        {
            acceptedSocket.readData(
                withTimeout:-1,
                tag:0)
        }
    }
}
