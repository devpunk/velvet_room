import Foundation

extension MVitaLink
{
    //MARK: private
    
    private func unknownEventReceived()
    {
        let message:String = String.localizedModel(
            key:"MVitaLink_unknownEventReceived")
        delegate?.vitaLinkError(message:message)
    }
    
    private func requestSettings(
        event:MVitaPtpMessageInEvent)
    {
        changeStrategy(strategyType:
            MVitaLinkStrategyRequestSettings.self)
        strategyEvent(event:event)
        
        linkCommand.requestSettings(event:event)
    }
    
    private func sendStorageSize(
        event:MVitaPtpMessageInEvent)
    {
        changeStrategy(strategyType:
            MVitaLinkStrategySendStorageSize.self)
        strategyEvent(event:event)
    }
    
    //MARK: internal
    
    func receivedEvent(event:MVitaPtpMessageInEvent)
    {
        switch event.code
        {
        case MVitaPtpEvent.requestSettings:
            
            requestSettings(event:event)
            
            break
            
        case MVitaPtpEvent.sendStorageSize:
            
            sendStorageSize(event:event)
            
            break
            
        default:
            
            unknownEventReceived()
            
            break
        }
    }
}
