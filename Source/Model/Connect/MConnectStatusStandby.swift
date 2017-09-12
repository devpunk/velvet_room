import Foundation

struct MConnectStatusStandby:MConnectStatusProtocol
{
    let viewType:View<ArchConnect>.Type = VConnectStandby.self
    let shouldStart:Bool = true
}
