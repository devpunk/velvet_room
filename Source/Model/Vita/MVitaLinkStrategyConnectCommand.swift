import Foundation

final class MVitaLinkStrategyConnectCommand:MVitaLinkStrategyProtocol
{
    private(set) var model:MVitaLink?
    
    init(model:MVitaLink)
    {
        self.model = model
    }
    
    //MARK: protocol
    
    func commandConnected()
    {
        model?.connectEvent()
    }
    
    func commandDisconnected()
    {
        model?.connectCommand()
    }
}
