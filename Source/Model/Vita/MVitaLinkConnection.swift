import Foundation

extension MVitaLink
{
    //MARK: internal
    
    func connectCommand()
    {
        changeStrategy(strategyType:
            MVitaLinkStrategyConnectCommand.self)
        linkCommand.connect()
    }
    
    func connectEvent()
    {
        changeStrategy(strategyType:
            MVitaLinkStrategyConnectEvent.self)
        linkEvent.connect()
    }
    
    func requestCommand()
    {
        changeStrategy(strategyType:
            MVitaLinkStrategyRequestCommand.self)
        linkCommand.request()
    }
    
    func requestEvent(
        requestCommand:MVitaPtpMessageInRequestCommand)
    {
        changeStrategy(strategyType:
            MVitaLinkStrategyRequestEvent.self)
        linkEvent.request(requestCommand:requestCommand)
    }
    
    func openSession()
    {
        changeStrategy(strategyType:
            MVitaLinkStrategyOpenSession.self)
        linkCommand.openSession()
    }
    
    func requestVitaInfo()
    {
        delegate?.stopBroadcast()
        
        changeStrategy(strategyType:
            MVitaLinkStrategyRequestVitaInfo.self)
        linkCommand.requestVitaInfo()
    }
    
    func sendLocalInfo(vitaInfo:MVitaInfo)
    {
        self.vitaInfo = vitaInfo
        
        changeStrategy(strategyType:
            MVitaLinkStrategySendLocalInfo.self)
    }
    
    func requestVitaCapabilities()
    {
        changeStrategy(strategyType:
            MVitaLinkStrategyRequestVitaCapabilities.self)
        linkCommand.requestVitaCapabilities()
    }
}
