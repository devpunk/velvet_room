import Foundation

extension MConnected
{
    //MARK: private
    
    private func addLogs(logs:[MVitaLinkLogProtocol])
    {
        let events:[MConnectedEvent] = MConnectedEvent.factoryEvents(
            logs:logs)
        self.events.append(contentsOf:events)
        
        view?.updateEvents()
    }
    
    //MARK: delegate
    
    func vitaLinkError(message:String)
    {
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
        
            var logs:[MVitaLinkLogProtocol] = vitaLink?.log
        
        else
        {
            return
        }
        
        let currentEvents:Int = events.count
        let removeRange:Range<Int> = Range<Int>(
            0 ..< currentEvents)
        logs.removeSubrange(removeRange)
        
        addLogs(logs:logs)
    }
}
