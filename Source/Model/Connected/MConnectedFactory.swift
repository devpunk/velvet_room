import Foundation

extension MConnected
{
    //MARK: private
    
    private func factoryEvent(
        log:MVitaLinkLogProtocol) -> MConnectedEvent
    {
        
    }
    
    //MARK: internal
    
    static func factoryEvents(
        logs:[MVitaLinkLogProtocol]) -> [MConnectedEvent]
    {
        var events:[MConnectedEvent] = []
        
        for log:MVitaLinkLogProtocol in logs
        {
            let event:MConnectedEvent
        }
        
        return events
    }
}
