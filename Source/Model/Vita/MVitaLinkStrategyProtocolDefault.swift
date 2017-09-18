import Foundation

extension MVitaLinkStrategyProtocol
{
    func startConnection() { }
    func commandConnected() { }
    func eventConnected() { }
    func commandRead(data:Data) {  }
    
    func commandDisconnected()
    {
        model?.disconnected()
    }
    
    func eventDisconnected()
    {
        model?.disconnected()
    }
}
