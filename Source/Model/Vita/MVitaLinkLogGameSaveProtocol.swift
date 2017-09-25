import UIKit

protocol MVitaLinkLogGameSaveProtocol:MVitaLinkLogProtocol
{
    var transferType:MVitaLinkLogTransferType { get }
    var image:UIImage { get }
    var gameName:String { get }
}
