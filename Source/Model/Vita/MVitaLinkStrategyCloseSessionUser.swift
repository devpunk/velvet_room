import Foundation

final class MVitaLinkStrategyCloseSessionUser:MVitaLinkStrategyCloseSession
{
    override func failed()
    {
        model?.delegate?.vitaLinkConnectionClosed()
    }
    
    override func success()
    {
        model?.delegate?.vitaLinkConnectionClosed()
    }
}
