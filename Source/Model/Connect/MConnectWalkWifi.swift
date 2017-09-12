import UIKit

struct MConnectWalkWifi:MConnectWalkProtocol
{
    let icon:UIImage = #imageLiteral(resourceName: "assetConnectWalkWifi")
    let title:String = String.localizedModel(
        key:"MConnectWalkWifi_title")
    let descr:String = String.localizedModel(
        key:"MConnectWalkWifi_descr")
}
