import Foundation

final class MConnectingSocket
{
    weak var model:MConnecting?
    var configuration:MVitaConfiguration?
    var modelUdp:MConnectingSocketUdp?
    var modelTcp:MConnectingSocketTcp?
    
    init(model:MConnecting)
    {
        self.model = model
    }
    
    //MARK: internal
    
    func cancel()
    {
        modelTcp?.cancel()
        modelUdp?.cancel()
    }
}
