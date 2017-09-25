import Foundation

struct MVitaLinkLogSystem:MVitaLinkLogProtocol
{
    let logType:MVitaLinkLogType = MVitaLinkLogType.system
    let systemType:MVitaLinkLogSystemType
    let timestamp:TimeInterval
}
