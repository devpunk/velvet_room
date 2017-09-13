import Foundation

struct MConnectingStatusPin:MConnectingStatusProtocol
{
    let viewType:View<ArchConnecting>.Type = VConnectingPin.self
    let buttonTitle:String = String.localizedModel(
        key:"MConnectingStatusPin_buttonTitle")
}
