import UIKit

struct MConnectWalkCover:MConnectWalkProtocol
{
    let icon:UIImage = #imageLiteral(resourceName: "assetConnectWalkCover")
    let title:String = String.localizedModel(
        key:"MConnectWalkCover_title")
    let descr:String = String.localizedModel(
        key:"MConnectWalkCover_descr")
}
