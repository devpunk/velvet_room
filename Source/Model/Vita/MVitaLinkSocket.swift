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
            model.delegate?.vitaLinkError(message:message)
        }
    }
    
    final func writeData(
        data:Data)
    {
        socket.write(
            data,
            withTimeout:-1,
            tag:0)
    }
    
    final func readData()
    {
        socket.readData(
            withTimeout:-1,
            tag:0)
    }
    
    final func writeMessage(
        message:MVitaPtpMessageOutProtocol)
    {
        writeData(data:message.data)
    }
    
    final func writeMessageAndRead(
        message:MVitaPtpMessageOutProtocol)
    {
        writeMessage(message:message)
        readData()
    }
    
    final func cancel()
    {
        socket.delegate = nil
        socket.disconnect()
    }
}
