import Foundation

struct MConnectingStatusPin:MConnectingStatusProtocol
{
    let viewType:View<ArchConnecting>.Type = VConnectingPin.self
}
