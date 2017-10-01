import Foundation

extension MVitaLink
{
    //MARK: private
    
    private func unknownEventReceived()
    {
        let message:String = String.localizedModel(
            key:"MVitaLink_unknownEventReceived")
        errorCloseConnection(
            message:message)
    }
    
    private func terminateReceived()
    {
        let message:String = String.localizedModel(
            key:"MVitaLink_terminateReceived")
        delegate?.vitaLinkError(message:message)
        delegate?.vitaLinkClean()
    }
    
    private func sendItemsCount(
        event:MVitaPtpMessageInEvent)
    {
        changeStrategy(strategyType:
            MVitaLinkStrategySendItemsCount.self)
        
        strategyDatabase()
        strategyEvent(event:event)
    }
    
    private func sendItemsMetadata(
        event:MVitaPtpMessageInEvent)
    {
        changeStrategy(strategyType:
            MVitaLinkStrategySendItemsCount.self)
        
        strategyDatabase()
        strategyEvent(event:event)
    }
    
    private func requestItemStatus(
        event:MVitaPtpMessageInEvent)
    {
        changeStrategy(strategyType:
            MVitaLinkStrategyRequestItemStatus.self)
        strategyEvent(event:event)
        
        linkCommand.requestItemStatus(event:event)
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
    
    private func requestItemTreat(
        event:MVitaPtpMessageInEvent)
    {
        changeStrategy(strategyType:
            MVitaLinkStrategyRequestItemTreat.self)
        strategyEvent(event:event)
        
        linkCommand.requestItemTreat(event:event)
    }
    
    private func itemPropertyChanged()
    {
        listenEvents()
    }
    
    //MARK: internal
    
    func receivedEvent(event:MVitaPtpMessageInEvent)
    {
        switch event.code
        {
        case MVitaPtpEvent.sendItemsCount:
            
            sendItemsCount(event:event)
            
            break
            
        case MVitaPtpEvent.sendItemsMetaData:
            
            sendItemsMetadata(event:event)
            
            break
            
        case MVitaPtpEvent.requestItemStatus:
            
            requestItemStatus(event:event)
            
            break
            
        case MVitaPtpEvent.requestSettings:
            
            requestSettings(event:event)
            
            break
            
        case MVitaPtpEvent.sendStorageSize:
            
            sendStorageSize(event:event)
            
            break
            
        case MVitaPtpEvent.requestItemTreat:
            
            requestItemTreat(event:event)
            
            break
            
        case MVitaPtpEvent.terminate:
            
            terminateReceived()
            
            break
            
        case MVitaPtpEvent.itemPropertyChanged:
            
            itemPropertyChanged()
            
            break
            
        default:
            
            unknownEventReceived()
            
            break
        }
    }
}
