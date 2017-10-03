import UIKit

extension MConnected
{
    private typealias Router = (
        (MVitaLinkLogProtocol,
        String) -> (MConnectedEventProtocol?))
    
    private static let kRouterMap:[
        MVitaLinkLogType:Router] = [
            MVitaLinkLogType.system:factorySystem,
            MVitaLinkLogType.gameSave:factoryGameSave]
    
    //MARK: private
    
    private class func factorySystem(
        log:MVitaLinkLogProtocol,
        timestamp:String) -> MConnectedEventProtocol?
    {
        guard
            
            let log:MVitaLinkLogSystem = log as? MVitaLinkLogSystem,
            let title:String = kEventSystemTitleMap[
                log.systemType]
            
        else
        {
            return nil
        }
        
        let icon:UIImage = #imageLiteral(resourceName: "assetConnectSystemIcon")
        let event:MConnectedEventIcon = MConnectedEventIcon(
            icon:icon,
            title:title,
            timestamp:timestamp)
        
        return event
    }
    
    private class func factoryGameSave(
        log:MVitaLinkLogProtocol,
        timestamp:String) -> MConnectedEventProtocol?
    {
        guard
            
            let log:MVitaLinkLogGameSave = log as? MVitaLinkLogGameSave,
            let titleTransfer:String = kEventTransferTitleMap[
                log.transferType],
            let badge:UIImage = kEventBadgeMap[
                log.transferType]
            
        else
        {
            return nil
        }
        
        let titleGameSave:String = String.localizedModel(key:
            "MConnected_eventLogGameSave")
        
        var descr:String = String()
        descr.append(titleGameSave)
        descr.append(titleTransfer)
        
        let event:MConnectedEventPicture = MConnectedEventPicture(
            picture:log.image,
            badge:badge,
            title:log.gameName,
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
                
                let router:Router = kRouterMap[
                    log.logType],
                let event:MConnectedEventProtocol = router(
                    log,
                    timestamp)
                
            else
            {
                continue
            }
            
            events.append(event)
        }
        
        return events
    }
}
