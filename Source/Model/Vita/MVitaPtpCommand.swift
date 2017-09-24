import Foundation

enum MVitaPtpCommand:UInt16
{
    case unknown
    case openSession = 4098
    case success = 8193
    case error = 8194
    case requestVitaInfo = 38161
    case sendLocalInfo = 38172
    case sendLocalStatus = 38186
    case requestVitaCapabilities = 38203
    case sendLocalCapabilities = 38204
}
