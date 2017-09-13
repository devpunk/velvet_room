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
    
    func connectionTimedout()
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
    
    func foundError(errorMessage:String)
    {
        cancelAndClean()
        statusError(errorMessage:errorMessage)
        view?.updateStatus()
    }
}
