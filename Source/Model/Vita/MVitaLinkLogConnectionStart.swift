import UIKit

struct MVitaLinkLogConnectionStart:MVitaLinkLogProtocol
{
    let logType:MVitaLinkLogType = MVitaLinkLogType.connection
    let image:UIImage? = nil
    let descr:String = String.localizedModel(
        key:"MVitaLinkLogConnectionStart_descr")
    let timestamp:TimeInterval
    
    init()
    {
        timestamp = Date().timeIntervalSinceNow
    }
}
