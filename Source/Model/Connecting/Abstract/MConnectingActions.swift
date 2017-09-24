import Foundation

extension MConnecting
{
    //MARK: private
    
    private func startVitaLink(
        device:MVitaDevice,
        configuration:MVitaConfiguration)
    {
        let vitaLink:MVitaLink = MVitaLink(
            device:device,
            configuration:configuration,
            delegate:self)
        
        self.vitaLink = vitaLink
        vitaLink.strategy?.startConnection()
    }
    
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
    
    func registered()
    {
        guard
            
            let device:MVitaDevice = self.device,
            let configuration:MVitaConfiguration = socket?.configuration
        
        else
        {
            let message:String = String.localizedModel(
                key:"MConnecting_errorRegistred")
            foundError(errorMessage:message)
            
            return
        }
        
        startVitaLink(device:device, configuration:configuration)
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
        cancelBroadcast()
        modelTimer.cancel()
        vitaLink?.cancel()
        vitaLink = nil
    }
    
    func cancelBroadcast()
    {
        socket?.cancel()
        socket = nil
        device = nil
        modelPin = nil
    }
    
    func foundError(errorMessage:String)
    {
        cancelAndClean()
        statusError(errorMessage:errorMessage)
        view?.updateStatus()
    }
}
