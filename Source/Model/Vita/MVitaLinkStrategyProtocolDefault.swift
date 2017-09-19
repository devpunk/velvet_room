import Foundation

extension MVitaLinkStrategyProtocol
{
    func startConnection() { }
    func commandConnected() { }
    func eventConnected() { }
    func commandReceived(
        header:MVitaPtpMessageInHeader,
        data:Data) {  }
    func eventReceived(
        header:MVitaPtpMessageInHeader,
        data:Data) {  }
    
    func commandDisconnected()
    {
        model?.disconnected()
    }
    
    func eventDisconnected()
    {
        model?.disconnected()
    }
}
