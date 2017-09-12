import Foundation

struct MConnectStatusLoading:MConnectStatusProtocol
{
    let viewType:View<ArchConnect>.Type = VConnectLoading.self
    let shouldStart:Bool = false
}
