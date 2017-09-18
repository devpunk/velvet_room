import Foundation

extension MVitaLink
{
    //MARK: internal
    
    func cancel()
    {
        linkCommand.cancel()
        linkEvent.cancel()
    }
    
    func disconnected()
    {
        let message:String = String.localizedModel(
            key:"MVitaLink_errorDisconnected")
        delegate?.linkError(message:message)
    }
    
    func connectCommand()
    {
        strategyConnectCommand()
        
        do
        {
            try linkCommand.socket.connect(
                toHost:device.ipAddress,
                onPort:device.port)
        }
        catch
        {
            let message:String = String.localizedModel(
                key:"MVitaLink_errorConnectCommand")
            delegate?.linkError(message:message)
            
            return
        }
    }
    
    func connectEvent()
    {
        strategyConnectEvent()
        
        do
        {
            try linkEvent.socket.connect(
                toHost:device.ipAddress,
                onPort:device.port)
        }
        catch
        {
            let message:String = String.localizedModel(
                key:"MVitaLink_errorConnectEvent")
            delegate?.linkError(message:message)
            
            return
        }
    }
    
    func requestCommand()
    {
        
    }
}
