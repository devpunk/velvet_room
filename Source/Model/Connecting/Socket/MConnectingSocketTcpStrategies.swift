import Foundation

extension MConnectingSocketTcp
{
    //MARK: private
    
    private func socketWrite(string:String)
    {
        guard
            
            let data:Data = string.data(
                using:String.Encoding.utf8,
                allowLossyConversion:false)
            
        else
        {
            return
        }
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.socketWrite(data:data)
        }
    }
    
    private func socketWrite(data:Data)
    {
        acceptedSocket?.write(
            data,
            withTimeout:0,
            tag:0)
        acceptedSocket?.readData(
            withTimeout:0,
            tag:0)
    }
    
    //MARK: internal
    
    func strategyShowpin()
    {
        model?.model?.createPin()
        strategyReplyOk()
    }
    
    func strategyConnect(device:MVitaDevice)
    {
        self.device = device
        strategyReplyOk()
    }
    
    func strategyReplyOk()
    {
        guard
        
            let reply:String = model?.configuration.broadcast.replyOk
        
        else
        {
            return
        }
        
        socketWrite(string:reply)
    }
    
    func strategyReplyPinError()
    {
        guard
            
            let reply:String = model?.configuration.broadcast.replyPinError
            
        else
        {
            return
        }
        
        socketWrite(string:reply)
    }
    
    func strategyReplyConnected()
    {
        guard
            
            let reply:String = model?.configuration.broadcast.replyConnected
            
        else
        {
            return
        }
        
        socketWrite(string:reply)
    }
    
    func strategyReplyConnectingError()
    {
        guard
            
            let reply:String = model?.configuration.broadcast.replyConnectingError
            
        else
        {
            return
        }
        
        socketWrite(string:reply)
    }
}
