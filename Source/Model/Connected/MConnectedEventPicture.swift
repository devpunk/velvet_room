import UIKit

struct MConnectedEventPicture:MConnectedEventProtocol
{
    let reusableIdentifier:String = VConnectedOnEventsCellPicture.reusableIdentifier
    let picture:UIImage
    let title:String
    let descr:String
    let timestamp:String
}
