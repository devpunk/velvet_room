import UIKit

final class MHomeSaveDataItem
{
    weak var coredataModel:DVitaIdentifier?
    let gameName:String
    let lastUpdated:String
    let thumbnail:UIImage?
    
    init(
        coredataModel:DVitaIdentifier,
        gameName:String,
        lastUpdated:String,
        thumbnail:UIImage?)
    {
        self.coredataModel = coredataModel
        self.gameName = gameName
        self.lastUpdated = lastUpdated
        self.thumbnail = thumbnail
    }
}
