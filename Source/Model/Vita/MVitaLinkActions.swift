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
            
            let strategyEvent:MVitaLinkStrategyEventProtocol = strategy as? MVitaLinkStrategyEventProtocol
            
        else
        {
            return
        }
        
        strategyEvent.config(event:event)
    }
    
    func addToLog(
        logItem:MVitaLinkLogProtocol)
    {
        log.append(logItem)
        
        DispatchQueue.global(
            qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.delegate?.vitaLinkLogUpdated()
        }
    }
    
    func closeConnectionDueToError(message:String)
    {
        closeConnection()
        delegate?.vitaLinkError(message:message)
    }
    
    func closeConnection()
    {
        sendLocalStatus(
            status:MVitaPtpLocalStatus.connectionEnd)
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
        delegate?.vitaLinkError(message:message)
    }
    
    func sendLocalStatus(status:MVitaPtpLocalStatus)
    {
        let strategyType:MVitaLinkStrategySendLocalStatus.Type = MVitaLink.factoryStrategyStatus(
            status:status)
        
        changeStrategy(strategyType:strategyType)
        linkCommand.sendLocalStatus(status:status)
    }
    
    func listenEvents()
    {
        changeStrategy(strategyType:
            MVitaLinkStrategyListenEvents.self)
        linkEvent.readData()
    }
}
