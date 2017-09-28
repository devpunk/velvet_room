import Foundation

extension MConnected
{
    //MARK: private
    
    private func addLogs(logs:[MVitaLinkLogProtocol])
    {
        let events:[MConnectedEventProtocol] = MConnected.factoryEvents(
            logs:logs)
        self.events.append(contentsOf:events)
        
        view?.updateEvents()
    }
    
    //MARK: internal
    
    func start(vitaLink:MVitaLink)
    {
        self.vitaLink = vitaLink
        vitaLink.delegate = self
    }
    
    func updateEvents(logs:[MVitaLinkLogProtocol])
    {
        var logs:[MVitaLinkLogProtocol] = logs
        let currentEvents:Int = events.count
        let removeRange:Range<Int> = Range<Int>(
            0 ..< currentEvents)
        logs.removeSubrange(removeRange)
        
        addLogs(logs:logs)
    }
    
    func closeConnection()
    {
        vitaLink?.userCloseConnection()
    }
    
    func cancelAndClean()
    {
        vitaLink?.cancel()
        vitaLink = nil
    }
    
    func foundError(errorMessage:String)
    {
        statusError(errorMessage:errorMessage)
        view?.updateStatus()
    }
}
