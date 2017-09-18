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
            
        }
    }
}
