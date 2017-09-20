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
        changeStrategy(strategyType:
            MVitaLinkStrategyRequestVitaInfo.self)
        linkCommand.requestVitaInfo()
    }
}
