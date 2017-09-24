import Foundation

extension MConnecting
{
    //MARK: delegate
    
    func linkError(message:String)
    {
        foundError(errorMessage:message)
    }
    
    func stopBroadcast()
    {
        cancelBroadcast()
    }
    
    func connectionReady()
    {
        guard
        
            let controller:CConnecting = view?.controller as? CConnecting
        
        else
        {
            return
        }
        
        controller.connectionReady()
    }
}
