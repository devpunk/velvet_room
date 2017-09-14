import Foundation
import CocoaAsyncSocket

final class MConnectingSocketUdp:
    NSObject,
    GCDAsyncUdpSocketDelegate
{
    private let socket:GCDAsyncUdpSocket
    private let queue:DispatchQueue
    private let configuration:MVitaConfiguration
    
    init(
        socket:GCDAsyncUdpSocket,
        queue:DispatchQueue,
        configuration:MVitaConfiguration)
    {
        self.socket = socket
        self.queue = queue
        self.configuration = configuration
    }
}
