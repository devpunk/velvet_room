import Foundation

extension MVitaLink
{
    //MARK: internal
    
    func changeStrategy(
        strategyType:MVitaLinkStrategyProtocol.Type)
    {
        strategy = strategyType.init(model:self)
    }
    
    func strategyEvent(
        event:MVitaPtpMessageInEvent)
    {
        guard
            
            var strategyEvent:MVitaLinkStrategyEventProtocol = strategy as? MVitaLinkStrategyEventProtocol
            
        else
        {
            return
        }
        
        strategyEvent.event = event
    }
    
    func cancel()
    {
        linkCommand.cancel()
        linkEvent.cancel()
    }
    
    func disconnected()
    {
        let message:String = String.localizedModel(
            key:"MVitaLink_errorDisconnected")
        delegate?.linkError(message:message)
    }
    
    func sendLocalStatus(status:MVitaPtpLocalStatus)
    {
        changeStrategy(strategyType:
            MVitaLinkStrategySendLocalStatus.self)
        
        linkCommand.sendLocalStatus(status:status)
    }
    
    func listenEvents()
    {
        changeStrategy(strategyType:
            MVitaLinkStrategyListenEvents.self)
        linkEvent.readData()
    }
}
