import Foundation

struct MVitaPtpType
{
    static let commandRequest:UInt32 = 1
    static let commandRequestAccepted:UInt32 = 2
    static let eventRequest:UInt32 = 3
    static let eventRequestAccepted:UInt32 = 4
    static let command:UInt32 = 6
    static let commandAccepted:UInt32 = 7
    static let dataPacketStart:UInt32 = 9
    static let dataPacket:UInt32 = 10
    static let dataPacketEnd:UInt32 = 12
}
