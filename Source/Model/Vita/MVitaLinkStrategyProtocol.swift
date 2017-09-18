import Foundation

protocol MVitaLinkStrategyProtocol
{
    weak var model:MVitaLink? { get }
    
    init(model:MVitaLink)
    
    func startConnection()
    func commandConnected()
    func commandDisconnected()
}
