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
    
    //MARK: internal
    
    func connect()
    {
        guard
        
            let model:MVitaLink = self.model
        
        else
        {
            return
        }
        
        do
        {
            try socket.connect(
                toHost:model.device.ipAddress,
                onPort:model.device.port)
        }
        catch
        {
            let message:String = String.localizedModel(
                key:"MVitaLinkCommand_errorConnect")
            model.delegate?.linkError(message:message)
        }
    }
    
    func cancel()
    {
        socket.delegate = nil
        socket.disconnect()
    }
}
