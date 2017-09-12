import Foundation

struct MConnectStatusConnected:MConnectStatusProtocol
{
    let viewType:View<ArchConnect>.Type = VConnectConnected.self
    let shouldStart:Bool = false
}
