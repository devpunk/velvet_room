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
                key:"MVitaLinkEvent_errorConnect")
            model.delegate?.linkError(message:message)
        }
    }
    
    func request()
    {
        let message:MVitaPtpMessageOutRequestCommand = MVitaPtpMessageOutRequestCommand()
        
        socket.write(
            message.data,
            withTimeout:0,
            tag:0)
        socket.readData(
            withTimeout:0,
            tag:0)
    }
    
    func cancel()
    {
        socket.delegate = nil
        socket.disconnect()
    }
}
