import Foundation

extension MVitaLink
{
    //MARK: internal
    
    func connectCommand()
    {
        print("connect command")
        
        changeStrategy(strategyType:
            MVitaLinkStrategyConnectCommand.self)
        linkCommand.connect()
    }
    
    func connectEvent()
    {
        print("connect event")
        
        changeStrategy(strategyType:
            MVitaLinkStrategyConnectEvent.self)
        linkEvent.connect()
    }
    
    func requestCommand()
    {
        print("request command")
        
        changeStrategy(strategyType:
            MVitaLinkStrategyRequestCommand.self)
        linkCommand.request()
    }
    
    func requestEvent(
        requestCommand:MVitaPtpMessageInRequestCommand)
    {
        print("request event")
        
        changeStrategy(strategyType:
            MVitaLinkStrategyRequestEvent.self)
        linkEvent.request(requestCommand:requestCommand)
    }
    
    func openSession()
    {
        print("open session")
        
        changeStrategy(strategyType:
            MVitaLinkStrategyOpenSession.self)
        linkCommand.openSession()
    }
    
    func requestVitaInfo()
    {
        print("request vita info")
        delegate?.stopBroadcast()
        
        changeStrategy(strategyType:
            MVitaLinkStrategyRequestVitaInfo.self)
        linkCommand.requestVitaInfo()
    }
}
