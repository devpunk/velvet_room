import UIKit

final class MHomeSaveDataItem
{
    var coredataModel:DVitaIdentifier?
    let shortDescr:NSAttributedString
    let thumbnail:UIImage?
    
    init(
        coredataModel:DVitaIdentifier,
        shortDescr:NSAttributedString,
        thumbnail:UIImage?)
    {
        self.coredataModel = coredataModel
        self.shortDescr = shortDescr
        self.thumbnail = thumbnail
    }
}
