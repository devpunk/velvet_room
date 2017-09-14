import Foundation

final class MConnectingSocket
{
    weak var model:MConnecting?
    private var configuration:MVitaConfiguration?
    
    init(model:MConnecting)
    {
        self.model = model
    }
    
    //MARK: private
    
    private func asyncStart()
    {
        guard
        
            let configuration:MVitaConfiguration = MVitaConfiguration.factoryConfiguration()
        
        else
        {
            failedConfiguration()
            return
        }
        
        self.configuration = configuration
    }
    
    private func failedConfiguration()
    {
        let message:String = String.localizedModel(
            key:"MConnectingSocket_failedConfiguration")
        model?.foundError(errorMessage:message)
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
