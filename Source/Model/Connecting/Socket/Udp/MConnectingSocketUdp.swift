import Foundation
import CocoaAsyncSocket

final class MConnectingSocketUdp
{
    var replyAvaiable:Data?
    private(set) weak var model:MConnectingSocket?
    private let socket:GCDAsyncUdpSocket
    private let delegate:MConnectingSocketUdpDelegate
    private let queue:DispatchQueue
    
    init(
        model:MConnectingSocket,
        socket:GCDAsyncUdpSocket,
        delegate:MConnectingSocketUdpDelegate,
        queue:DispatchQueue)
    {
        self.model = model
        self.socket = socket
        self.delegate = delegate
        self.queue = queue
        
        factoryReplyAvailable()
    }
    
    //MARK: private
    
    private func searchBroadcast(string:String) -> Bool
    {
        guard
            
            let model:MConnectingSocket = self.model
            
        else
        {
            return false
        }
        
        let stringSeparated:[String] = string.components(
            separatedBy:
            model.configuration.lineSeparator)
        
        guard
        
            let firstComponent:String = stringSeparated.first,
            firstComponent.starts(
                with:
                model.configuration.broadcast.searchCommand),
            firstComponent.contains(
                model.configuration.broadcast.searchProtocol)
        
        else
        {
            return false
        }
        
        return true
    }
    
    //MARK: internal
    
    func cancel()
    {
        socket.setDelegate(nil)
        socket.close()
    }
    
    func receivedString(string:String, address:Data)
    {
        guard
        
            searchBroadcast(string:string),
            let replyAvailable:Data = self.replyAvaiable
        
        else
        {
            return
        }
        
        DispatchQueue.global(
            qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.socket.send(
                replyAvailable,
                toAddress:address,
                withTimeout:0,
                tag:0)
        }
    }
}
