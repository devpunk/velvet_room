import Foundation

struct MVitaConfiguration
{
    let broadcast:MVitaConfigurationBroadcast
    let device:MVitaConfigurationDevice
    let local:MVitaConfigurationLocal
    let lineSeparator:String
    let storageId:UInt32
    let port:UInt16
}
