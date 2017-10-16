import Foundation

final class MVitaLinkStrategyCloseSessionError:MVitaLinkStrategyCloseSession
{
    override func failed()
    {
        model?.delegate?.vitaLinkClean()
    }
    
    override func success()
    {
        model?.delegate?.vitaLinkClean()
    }
}
