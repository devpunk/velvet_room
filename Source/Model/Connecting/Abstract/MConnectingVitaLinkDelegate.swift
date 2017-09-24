import Foundation

extension MConnecting
{
    //MARK: delegate
    
    func vitaLinkError(message:String)
    {
        foundError(errorMessage:message)
    }
    
    func vitaLinkStopBroadcast()
    {
        cancelBroadcast()
    }
    
    func vitaLinkConnectionReady()
    {
        guard
        
            let controller:CConnecting = view?.controller as? CConnecting
        
        else
        {
            return
        }
        
        modelTimer.cancel()
        controller.connectionReady()
    }
}
