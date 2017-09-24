import Foundation

extension MVitaLink
{
    //MARK: internal
    
    func changeStrategy(
        strategyType:MVitaLinkStrategyProtocol.Type)
    {
        strategy = strategyType.init(model:self)
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
    
    func listenEvents()
    {
        changeStrategy(strategyType:
            MVitaLinkStrategyListenEvents.self)
        linkEvent.readData()
    }
}
