import UIKit

protocol MVitaLinkLogProtocol
{
    var logType:MVitaLinkLogType { get }
    var image:UIImage? { get }
    var descr:String { get }
    var timestamp:TimeInterval { get }
}