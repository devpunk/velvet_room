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
}
