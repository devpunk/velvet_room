import UIKit

extension MConnected
{
    //MARK: private
    
    private class func factoryEvent(
        log:MVitaLinkLogProtocol) -> MConnectedEventProtocol?
    {
        switch log.logType
        {
        case MVitaLinkLogType.system:
            
            let event:MConnectedEventProtocol? = factoryEvent(
                logSystem:log)
            
            return event
        
        case MVitaLinkLogType.gameSave:
            
            let event:MConnectedEventProtocol? = factoryEvent(
                logGameSave:log)
            
            return event
        }
    }
    
    private class func factoryEvent(
        logSystem:MVitaLinkLogProtocol) -> MConnectedEventProtocol?
    {
        guard
        
            let logSystem:MVitaLinkLogSystem = logSystem as? MVitaLinkLogSystem
        
        else
        {
            return nil
        }
        
        let icon:UIImage = 
        let event:MConnectedEventIcon = MConnectedEventIcon(
            icon: <#T##UIImage#>,
            title: <#T##String#>,
            timestamp:logSystem.timestamp)
    }
    
    private class func factoryEvent(
        logGameSave:MVitaLinkLogProtocol) -> MConnectedEventProtocol?
    {
        
    }
    
    private class func factoryTitle(
        logSystemType:MVitaLinkLogSystemType) -> String
    {
        let title:String
        
        switch logSystemType
        {
        case MVitaLinkLogSystemType.connectionStart:
            
            title = String.localizedModel(key:
            "MConnected_eventSystemConnectionStart")
            
            break
        }
        
        return title
    }
    
    //MARK: internal
    
    class func factoryEvents(
        logs:[MVitaLinkLogProtocol]) -> [MConnectedEventProtocol]
    {
        var events:[MConnectedEventProtocol] = []
        
        for log:MVitaLinkLogProtocol in logs
        {
            guard
                
                let event:MConnectedEventProtocol = factoryEvent(
                    log:log)
            
            else
            {
                continue
            }
            
            events.append(event)
        }
        
        return events
    }
}
