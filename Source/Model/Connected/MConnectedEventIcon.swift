import UIKit

struct MConnectedEventIcon:MConnectedEventProtocol
{
    let reusableIdentifier:String = VConnectedOnEventsCellIcon.reusableIdentifier
    let icon:UIImage
    let title:String
    let timestamp:String
}
