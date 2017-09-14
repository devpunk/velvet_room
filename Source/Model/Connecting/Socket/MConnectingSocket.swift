import Foundation

final class MConnectingSocket
{
    weak var model:MConnecting?
    private var configuration:MVitaConfiguration?
    
    init(model:MConnecting)
    {
        self.model = model
    }
    
    //MARK: internal
    
    func cancel()
    {
        
    }
}
