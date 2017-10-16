import UIKit

struct MSaveDataRecord:MSaveDataProtocol
{
    let height:CGFloat = 160
    let reusableIdentifier:String = VSaveDataListCellRecord.reusableIdentifier
    let record:NSAttributedString
}
