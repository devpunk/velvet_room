import Foundation

extension MConnected
{
    //MARK: delegate
    
    func vitaLinkError(message:String)
    {
        foundError(errorMessage:message)
    }
    
    func vitaLinkConnectionClosed()
    {
        guard
            
            let controller:CConnected = view?.controller as? CConnected
            
        else
        {
            return
        }
        
        controller.connectionClosed()
    }
    
    func vitaLinkLogUpdated()
    {
        guard
            
            let logs:[MVitaLinkLogProtocol] = vitaLink?.log
            
        else
        {
            return
        }
        
        updateEvents(logs:logs)
    }
}
