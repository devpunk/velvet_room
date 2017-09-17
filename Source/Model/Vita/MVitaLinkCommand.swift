import Foundation
import CocoaAsyncSocket

final class MVitaLinkCommand
{
    weak var model:MVitaLink?
    let socket:GCDAsyncSocket
    private let delegate:MVitaLinkCommandDelegate
    private let queue:DispatchQueue
    
    init(
        socket:GCDAsyncSocket,
        delegate:MVitaLinkCommandDelegate,
        queue:DispatchQueue)
    {
        self.socket = socket
        self.delegate = delegate
        self.queue = queue
    }
}
