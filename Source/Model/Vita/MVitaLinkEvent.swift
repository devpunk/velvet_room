import Foundation
import CocoaAsyncSocket

final class MVitaLinkEvent
{
    weak var model:MVitaLink?
    let socket:GCDAsyncSocket
    private let delegate:MVitaLinkEventDelegate
    private let queue:DispatchQueue
    
    init(
        socket:GCDAsyncSocket,
        delegate:MVitaLinkEventDelegate,
        queue:DispatchQueue)
    {
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
}
