import Foundation

final class MVitaLinkStrategyConnectEvent:MVitaLinkStrategyProtocol
{
    private(set) var model:MVitaLink?
    
    init(model:MVitaLink)
    {
        self.model = model
    }
    
    //MARK: protocol
    
    func eventConnected()
    {
        model?.requestCommand()
    }
}
