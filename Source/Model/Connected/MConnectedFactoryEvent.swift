import Foundation

extension MConnected
{
    private typealias Router = (
        (log:MVitaLinkLogProtocol,
        timestamp:String) -> (MConnectedEventProtocol?))
    
    //MARK: private
    
    private class func factoryEvent(
        log:MVitaLinkLogProtocol,
        timestamp:String) -> MConnectedEventProtocol?
    {
        switch log.logType
        {
        case MVitaLinkLogType.system:
            
            let event:MConnectedEventProtocol? = factoryEvent(
                logSystem:log,
                timestamp:timestamp)
            
            return event
            
        case MVitaLinkLogType.gameSave:
            
            let event:MConnectedEventProtocol? = factoryEvent(
                logGameSave:log,
                timestamp:timestamp)
            
            return event
        }
    }
    
    private class func factoryEvent(
        logSystem:MVitaLinkLogProtocol,
        timestamp:String) -> MConnectedEventProtocol?
    {
        guard
            
            let logSystem:MVitaLinkLogSystem = logSystem as? MVitaLinkLogSystem
            
            else
        {
            return nil
        }
        
        let icon:UIImage = #imageLiteral(resourceName: "assetConnectSystemIcon")
        let title:String = factoryTitle(
            logSystemType:logSystem.systemType)
        let event:MConnectedEventIcon = MConnectedEventIcon(
            icon:icon,
            title:title,
            timestamp:timestamp)
        
        return event
    }
    
    private class func factoryEvent(
        logGameSave:MVitaLinkLogProtocol,
        timestamp:String) -> MConnectedEventProtocol?
    {
        guard
            
            let logGameSave:MVitaLinkLogGameSave = logGameSave as? MVitaLinkLogGameSave
            
            else
        {
            return nil
        }
        
        let titleGameSave:String = String.localizedModel(key:
            "MConnected_eventLogGameSave")
        let titleTransfer:String = factoryTransferTitle(
            transferType:logGameSave.transferType)
        
        var descr:String = String()
        descr.append(titleGameSave)
        descr.append(titleTransfer)
        
        let badge:UIImage = factoryBadge(
            transferType:logGameSave.transferType)
        
        let event:MConnectedEventPicture = MConnectedEventPicture(
            picture:logGameSave.image,
            badge:badge,
            title:logGameSave.gameName,
            descr:descr,
            timestamp:timestamp)
        
        return event
    }
    
    //MARK: internal
    
    class func factoryEvents(
        logs:[MVitaLinkLogProtocol]) -> [MConnectedEventProtocol]
    {
        var events:[MConnectedEventProtocol] = []
        let dateFormatter:DateFormatter = factoryDateFormatter()
        
        for log:MVitaLinkLogProtocol in logs
        {
            let timestamp:String = dateFormatter.string(
                from:log.timestamp)
            
            guard
                
                let event:MConnectedEventProtocol = factoryEvent(
                    log:log,
                    timestamp:timestamp)
                
                else
            {
                continue
            }
            
            events.append(event)
        }
        
        return events
    }
}
