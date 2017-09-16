import Foundation

extension MConnecting
{
    //MARK: internal
    
    func start()
    {
        guard
        
            let socket:MConnectingSocket = MConnectingSocket(model:self)
        
        else
        {
            return
        }
        
        self.socket = socket
        socket.start()
    }
    
    func createPin()
    {
        modelPin = MConnectingPin()
        statusPin()
        view?.updateStatus()
    }
    
    func connectionTimedout()
    {
        socket?.cancel()
        socket = nil
        
        statusTimeout()
        view?.updateStatus()
    }
    
    func cancelAndClean()
    {
        modelTimer.cancel()
        
        socket?.cancel()
        socket = nil
    }
    
    func foundError(errorMessage:String)
    {
        cancelAndClean()
        statusError(errorMessage:errorMessage)
        view?.updateStatus()
    }
}
