import Foundation

struct MConnectingStatusLoading:MConnectingStatusProtocol
{
    let viewType:View<ArchConnecting>.Type = VConnectingLoading.self
    let buttonTitle:String = String.localizedModel(
        key:"MConnectingStatusLoading_buttonTitle")
}
