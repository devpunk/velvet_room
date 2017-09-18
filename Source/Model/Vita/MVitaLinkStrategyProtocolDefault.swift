import Foundation

extension MVitaLinkStrategyProtocol
{
    func startConnection() { }
    func commandConnected() { }
    func eventConnected() { }
    
    func commandDisconnected()
    {
        model?.disconnected()
    }
    
    func eventDisconnected()
    {
        model?.disconnected()
    }
}
