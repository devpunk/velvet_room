import Foundation

extension MConnected
{
    //MARK: delegate
    
    func vitaLinkError(message:String)
    {
    }
    
    func vitaLinkConnectionClosed()
    {
        guard
            
            let controller:CConnected = view?.controller as? CConnected
            
        else
        {
            return
        }
        
        controller.connectionClosed()
    }
    
    func vitaLinkLogUpdated()
    {
        
    }
}
