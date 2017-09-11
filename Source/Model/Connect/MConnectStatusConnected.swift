import Foundation

class MConnectStatusConnected:MConnectStatusProtocol
{
    let viewType:View<ArchConnect>.Type = VConnectConnected.self
    private weak var model:MConnect!
    
    required init(model:MConnect)
    {
        self.model = model
    }
}
