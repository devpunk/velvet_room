import Foundation

struct MConnectedStatusError:MConnectedStatusProtocol
{
    let viewType:View<ArchConnected>.Type = VConnectedError.self
    let errorMessage:String
}
