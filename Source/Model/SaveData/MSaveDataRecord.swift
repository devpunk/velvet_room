import UIKit

struct MSaveDataRecord:MSaveDataProtocol
{
    let height:CGFloat = 150
    let reusableIdentifier:String = VSaveDataListCellTitle.reusableIdentifier
    let record:NSAttributedString
}
