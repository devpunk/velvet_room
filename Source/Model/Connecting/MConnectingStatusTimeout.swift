import Foundation

struct MConnectingStatusTimeout:MConnectingStatusProtocol
{
    let viewType:View<ArchConnecting>.Type = VConnectingTimeout.self
}
