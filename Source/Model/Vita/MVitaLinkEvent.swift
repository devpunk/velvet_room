import Foundation

extension MVitaLink
{
    private typealias Router = (
        (MVitaLink) -> (MVitaPtpMessageInEvent) -> ())
    
    private static let kRouterMap:[
        MVitaPtpEvent:Router] = [
            MVitaPtpEvent.unknown:unknownEventReceived,
            MVitaPtpEvent.terminate:terminateReceived,
            MVitaPtpEvent.sendItemsCount:sendItemsCount,
            MVitaPtpEvent.sendItemsMetadata:sendItemsMetadata,
            MVitaPtpEvent.sendItem:sendItem,
            MVitaPtpEvent.requestItemStatus:requestItemStatus,
            MVitaPtpEvent.sendItemThumbnail:sendItemThumbnail,
            MVitaPtpEvent.requestSettings:requestSettings,
            MVitaPtpEvent.sendStorageSize:sendStorageSize,
            MVitaPtpEvent.requestItemTreat:requestItemTreat,
            MVitaPtpEvent.itemPropertyChanged:itemPropertyChanged]
    
    //MARK: private
    
    private func unknownEventReceived(
        event:MVitaPtpMessageInEvent)
    {
        let message:String = String.localizedModel(
            key:"MVitaLink_unknownEventReceived")
        errorCloseConnection(
            message:message)
    }
    
    private func terminateReceived(
        event:MVitaPtpMessageInEvent)
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
            MVitaLinkStrategyRequestItemsFilters.self)
        strategyEvent(event:event)
        
        linkCommand.requestItemsFilters(event:event)
    }
    
    private func sendItem(
        event:MVitaPtpMessageInEvent)
    {
        print("send item params: \(event.parameters)")
        
        changeStrategy(strategyType:
            MVitaLinkStrategySendItem.self)
        
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
    
    private func sendItemThumbnail(
        event:MVitaPtpMessageInEvent)
    {
        changeStrategy(strategyType:
            MVitaLinkStrategySendItemThumbnail.self)
        
        strategyDatabase()
        strategyEvent(event:event)
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
    
    private func itemPropertyChanged(
        event:MVitaPtpMessageInEvent)
    {
        listenEvents()
    }
    
    //MARK: internal
    
    func receivedEvent(event:MVitaPtpMessageInEvent)
    {
        print(event.code)
        
        guard
        
            let router:Router = MVitaLink.kRouterMap[
                event.code]
        
        else
        {
            return
        }
        
        router(self)(event)
    }
}
