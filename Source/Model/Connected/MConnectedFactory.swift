import Foundation

extension MConnected
{
    //MARK: private
    
    private class func factoryEvent(
        log:MVitaLinkLogProtocol) -> MConnectedEventProtocol
    {
        
    }
    
    
    
    //MARK: internal
    
    class func factoryEvents(
        logs:[MVitaLinkLogProtocol]) -> [MConnectedEventProtocol]
    {
        var events:[MConnectedEventProtocol] = []
        
        for log:MVitaLinkLogProtocol in logs
        {
            let event:MConnectedEventProtocol = factoryEvent(
                log:log)
            
            events.append(event)
        }
        
        return events
    }
}
