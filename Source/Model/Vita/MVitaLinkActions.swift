import Foundation

extension MVitaLink
{
    //MARK: internal
    
    func cancel()
    {
        linkCommand.cancel()
        linkEvent.cancel()
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
        
    }
}
