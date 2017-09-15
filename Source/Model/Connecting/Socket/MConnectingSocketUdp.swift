import Foundation
import CocoaAsyncSocket

final class MConnectingSocketUdp
{
    private let socket:GCDAsyncUdpSocket
    private let delegate:MConnectingSocketUdpDelegate
    private let queue:DispatchQueue
    private let configuration:MVitaConfiguration
    
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
    
    func receivedString(string:String)
    {
        guard
        
            searchBroadcast(string:string)
        
        else
        {
            return
        }
        
        
    }
}
