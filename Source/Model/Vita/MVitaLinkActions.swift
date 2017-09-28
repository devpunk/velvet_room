import Foundation

extension MVitaLink
{
    //MARK: private
    
    private func sendLocalStatus(
        status:MVitaPtpLocalStatus,
        strategyType:MVitaLinkStrategySendLocalStatus.Type)
    {
        changeStrategy(strategyType:strategyType)
        linkCommand.sendLocalStatus(status:status)
    }
    
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
    
    func errorCloseConnection(message:String)
    {
        let status:MVitaPtpLocalStatus = MVitaPtpLocalStatus.connectionEnd
        let strategyType:MVitaLinkStrategySendLocalStatus.Type = MVitaLinkStrategySendLocalStatusConnectionEndError.self
        sendLocalStatus(
            status:status,
            strategyType:strategyType)
        
        delegate?.vitaLinkError(message:message)
    }
    
    func userCloseConnection()
    {
        let status:MVitaPtpLocalStatus = MVitaPtpLocalStatus.connectionEnd
        let strategyType:MVitaLinkStrategySendLocalStatus.Type = MVitaLinkStrategySendLocalStatusConnectionEndUser.self
        sendLocalStatus(
            status:status,
            strategyType:strategyType)
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
        delegate?.vitaLinkClean()
    }
    
    func sendLocalStatus(status:MVitaPtpLocalStatus)
    {
        let strategyType:MVitaLinkStrategySendLocalStatus.Type = MVitaLink.factoryStrategyStatus(
            status:status)
        sendLocalStatus(
            status:status,
            strategyType:strategyType)
    }
    
    func listenEvents()
    {
        changeStrategy(strategyType:
            MVitaLinkStrategyListenEvents.self)
        linkEvent.readData()
    }
}
