import UIKit

extension MConnected
{
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
        
        let badge:UIImage = factoryBadge(
            transferType:logGameSave.transferType)
        let descr:String = String.localizedModel(key:
            "MConnected_eventLogGameSave")
        let event:MConnectedEventPicture = MConnectedEventPicture(
            picture:logGameSave.image,
            badge:badge,
            title:logGameSave.gameName,
            descr:descr,
            timestamp:timestamp)
        
        return event
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
    
    private class func factoryBadge(
        transferType:MVitaLinkLogTransferType) -> UIImage
    {
        switch transferType
        {
        case MVitaLinkLogTransferType.request:
            
            return #imageLiteral(resourceName: "assetConnectBadgeDownload")
            
        case MVitaLinkLogTransferType.send:
            
            return #imageLiteral(resourceName: "assetConnectBadgeUpload")
        }
    }
    
    private class func factoryDateFormatter() -> DateFormatter
    {
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.none
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        return dateFormatter
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
