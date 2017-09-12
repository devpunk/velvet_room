import Foundation

final class MConnectStatusLoading:MConnectStatusProtocol
{
    let viewType:View<ArchConnect>.Type = VConnectLoading.self
    let shouldStart:Bool = false
    private weak var model:MConnect!
    
    required init(model:MConnect)
    {
        self.model = model
    }
}
