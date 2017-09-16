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
        let stringSeparated:[String] = string.components(
            separatedBy:configuration.lineSeparator)
        
        guard
        
            let firstComponent:String = stringSeparated.first,
            firstComponent.starts(
                with:configuration.broadcast.searchCommand),
            firstComponent.contains(
                configuration.broadcast.searchProtocol)
        
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
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.socket.send(
                replyAvailable,
                toAddress:address,
                withTimeout:0,
                tag:0)
        }
    }
}
