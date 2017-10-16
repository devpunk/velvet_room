import Foundation

struct MVitaConfiguration
{
    let storage:MVitaConfigurationStorage
    let directory:MVitaConfigurationDirectory
    let broadcast:MVitaConfigurationBroadcast
    let device:MVitaConfigurationDevice
    let local:MVitaConfigurationLocal
    let lineSeparator:String
    let port:UInt16
}
