import Foundation

extension MVitaLink
{
    //MARK: private
    
    private func connectCommand()
    {
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
    
    //MARK: internal
    
    func cancel()
    {
        linkCommand.cancel()
        linkEvent.cancel()
    }
    
    func start()
    {
        
    }
}
