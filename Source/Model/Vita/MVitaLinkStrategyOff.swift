import Foundation

final class MVitaLinkStrategyOff:MVitaLinkStrategyProtocol
{
    private(set) var model:MVitaLink?
    
    init(model:MVitaLink)
    {
        self.model = model
    }
    
    //MARK: protocol
    
    func startConnection()
    {
        model?.start()
    }
}
