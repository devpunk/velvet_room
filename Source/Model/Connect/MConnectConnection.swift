import Foundation

extension MConnect
{
    //MARK: private
    
    private func startConnectionAccepted()
    {
        statusLoading()
        view?.update()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncStartConnection()
        }
    }
    
    private func asyncStartConnection()
    {
        
    }
    
    //MARK: internal
    
    func startConnection()
    {
        guard
            
            let status:MConnectStatusProtocol = self.status,
            status.shouldStart
            
        else
        {
            return
        }
        
        startConnectionAccepted()
    }
}
