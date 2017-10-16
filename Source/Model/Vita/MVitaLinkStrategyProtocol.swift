import Foundation

protocol MVitaLinkStrategyProtocol
{
    weak var model:MVitaLink? { get }
    
    init(model:MVitaLink)
    
    func startConnection()
    func commandConnected()
    func commandDisconnected()
    func eventConnected()
    func eventDisconnected()
    func commandWrite()
    func eventWrite()
    func commandReceived(
        header:MVitaPtpMessageInHeader,
        data:Data)
    func eventReceived(
        header:MVitaPtpMessageInHeader,
        data:Data)
}
