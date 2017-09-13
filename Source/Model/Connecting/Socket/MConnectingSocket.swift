import Foundation

final class MConnectingSocket
{
    private var configuration:MConnectingSocketConfiguration?
    
    //MARK: private
    
    private func asyncStart()
    {
        
    }
    
    //MARK: internal
    
    func start()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncStart()
        }
    }
    
    func cancel()
    {
        
    }
}
