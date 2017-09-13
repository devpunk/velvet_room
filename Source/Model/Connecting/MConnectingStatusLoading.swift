import Foundation

struct MConnectingStatusLoading:MConnectingStatusProtocol
{
    let viewType:View<ArchConnecting>.Type = VConnectingLoading.self
}
