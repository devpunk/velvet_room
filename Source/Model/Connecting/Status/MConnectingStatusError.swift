import Foundation

struct MConnectingStatusError:MConnectingStatusProtocol
{
    let errorMessage:String
    let viewType:View<ArchConnecting>.Type = VConnectingError.self
    let buttonTitle:String = String.localizedModel(
        key:"MConnectingStatusTimeout_buttonTitle")
}
