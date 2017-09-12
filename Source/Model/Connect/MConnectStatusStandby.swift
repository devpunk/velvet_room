import Foundation

final class MConnectStatusStandby:MConnectStatusProtocol
{
    let viewType:View<ArchConnect>.Type = VConnectStandby.self
    let shouldStart:Bool = true
    private weak var model:MConnect!
    
    required init(model:MConnect)
    {
        self.model = model
    }
}
