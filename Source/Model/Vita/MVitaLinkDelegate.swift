import Foundation

protocol MVitaLinkDelegate:class
{
    func vitaLinkError(message:String)
    func vitaLinkStopBroadcast()
    func vitaLinkConnectionReady()
    func vitaLinkConnectionClosed()
}
