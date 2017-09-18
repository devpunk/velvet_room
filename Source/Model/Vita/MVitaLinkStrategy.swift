import Foundation

extension MVitaLink
{
    //MARK: internal
    
    func strategyOff()
    {
        strategy = MVitaLinkStrategyOff(
            model:self)
    }
    
    func strategyConnectCommand()
    {
        strategy = MVitaLinkStrategyConnectCommand(
            model:self)
    }
    
    func strategyConnectEvent()
    {
        strategy = MVitaLinkStrategyConnectEvent(
            model:self)
    }
}
