import Foundation

class MConnectStatusConnected:MConnectStatusProtocol
{
    private weak var model:MConnect!
    
    required init(model:MConnect)
    {
        self.model = model
    }
}
