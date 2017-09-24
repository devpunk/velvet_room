import Foundation

protocol MVitaLinkDelegate:class
{
    func linkError(message:String)
    func stopBroadcast()
    func connectionReady()
}
