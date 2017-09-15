import Foundation
import CocoaAsyncSocket

final class MConnectingSocketTcp
{
    private let socket:GCDAsyncSocket
    private let delegate:MConnectingSocketTcpDelegate
    private let queue:DispatchQueue
    private let configuration:MVitaConfiguration
    
    init(
        socket:GCDAsyncSocket,
        delegate:MConnectingSocketTcpDelegate,
        queue:DispatchQueue,
        configuration:MVitaConfiguration)
    {
        self.socket = socket
        self.delegate = delegate
        self.queue = queue
        self.configuration = configuration
    }
    
    //MARK: internal
    
    func cancel()
    {
        socket.delegate = nil
        socket.disconnect()
    }
}
