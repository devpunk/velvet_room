import Foundation

final class MConnectStatusConnected:MConnectStatusProtocol
{
    let viewType:View<ArchConnect>.Type = VConnectConnected.self
    let shouldStart:Bool = false
    private weak var model:MConnect!
    
    required init(model:MConnect)
    {
        self.model = model
    }
}
