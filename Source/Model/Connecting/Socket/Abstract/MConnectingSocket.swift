import Foundation

final class MConnectingSocket
{
    weak var model:MConnecting?
    var modelUdp:MConnectingSocketUdp?
    var modelTcp:MConnectingSocketTcp?
    let configuration:MVitaConfiguration
    
    init?(model:MConnecting)
    {
        guard
            
            let configuration:MVitaConfiguration = MVitaConfiguration.factoryConfiguration()
            
        else
        {
            let message:String = String.localizedModel(
                key:"MConnectingSocket_failedConfiguration")
            model.foundError(errorMessage:message)
            
            return nil
        }
        
        self.configuration = configuration
        self.model = model
    }
    
    //MARK: internal
    
    func cancel()
    {
        modelTcp?.cancel()
        modelUdp?.cancel()
    }
}
