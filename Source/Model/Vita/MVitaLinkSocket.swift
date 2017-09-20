import Foundation
import CocoaAsyncSocket

class MVitaLinkSocket
{
    weak var model:MVitaLink?
    let socket:GCDAsyncSocket
    private let delegate:MVitaLinkPtpDelegate
    private let queue:DispatchQueue
    
    init(
        socket:GCDAsyncSocket,
        delegate:MVitaLinkPtpDelegate,
        queue:DispatchQueue)
    {
        self.socket = socket
        self.delegate = delegate
        self.queue = queue
    }
    
    //MARK: internal
    
    final func connect()
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
                key:"MVitaLinkSocket_errorConnect")
            model.delegate?.linkError(message:message)
        }
    }
    
    final func writeMessage(
        message:MVitaPtpMessageOutProtocol)
    {
        socket.write(
            message.data,
            withTimeout:0,
            tag:0)
        socket.readData(
            withTimeout:0,
            tag:0)
    }
    
    final func cancel()
    {
        socket.delegate = nil
        socket.disconnect()
    }
}
