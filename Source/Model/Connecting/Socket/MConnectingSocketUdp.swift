import Foundation
import CocoaAsyncSocket

final class MConnectingSocketUdp
{
    var replyAvaiable:Data?
    let configuration:MVitaConfiguration
    private let socket:GCDAsyncUdpSocket
    private let delegate:MConnectingSocketUdpDelegate
    private let queue:DispatchQueue
    
    init(
        socket:GCDAsyncUdpSocket,
        delegate:MConnectingSocketUdpDelegate,
        queue:DispatchQueue,
        configuration:MVitaConfiguration)
    {
        self.socket = socket
        self.delegate = delegate
        self.queue = queue
        self.configuration = configuration
        
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
