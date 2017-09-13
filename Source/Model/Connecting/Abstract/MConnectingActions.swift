import Foundation

extension MConnecting
{
    //MARK: internal
    
    func createPin()
    {
        modelPin = MConnectingPin()
        statusPin()
        view?.updateStatus()
    }
    
    func stopConnection()
    {
        socket.cancel()
        statusTimeout()
        view?.updateStatus()
    }
    
    func cancelAndClean()
    {
        modelTimer.cancel()
        socket.cancel()
    }
}
