import Foundation

enum MVitaPtpType:UInt32
{
    case unknown
    case commandRequest = 1
    case commandRequestAccepted = 2
    case eventRequest = 3
    case eventRequestAccepted = 4
    case command = 6
    case commandAccepted = 7
    case dataPacketStart = 9
    case dataPacket = 10
    case dataPacketEnd = 12
}
