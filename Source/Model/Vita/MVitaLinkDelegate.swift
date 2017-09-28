import Foundation

protocol MVitaLinkDelegate:class
{
    func vitaLinkError(message:String)
    func vitaLinkClean()
    func vitaLinkStopBroadcast()
    func vitaLinkConnectionReady()
    func vitaLinkConnectionClosed()
    func vitaLinkLogUpdated()
}
