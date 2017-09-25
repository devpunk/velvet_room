import UIKit

struct MVitaLinkLogGameSave:MVitaLinkLogProtocol
{
    let logType:MVitaLinkLogType = MVitaLinkLogType.gameSave
    let transferType:MVitaLinkLogTransferType
    let image:UIImage
    let gameName:String
    let timestamp:TimeInterval = Date().timeIntervalSinceNow
}
