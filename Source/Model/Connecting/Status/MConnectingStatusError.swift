import Foundation

struct MConnectingStatusError:MConnectingStatusProtocol
{
    let viewType:View<ArchConnecting>.Type = VConnectingTimeout.self
    let buttonTitle:String = String.localizedModel(
        key:"MConnectingStatusTimeout_buttonTitle")
}
