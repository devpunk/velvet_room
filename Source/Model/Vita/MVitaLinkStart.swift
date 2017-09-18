import Foundation

extension MVitaLink
{
    //MARK: internal
    
    func start()
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
}
