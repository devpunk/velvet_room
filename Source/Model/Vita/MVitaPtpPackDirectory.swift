import Foundation

struct MVitaPtpPackDirectory:MVitaPtpPackProtocol
{
    let data:Data
    
    init?(
        directory:DVitaItemDirectory,
        configuration:MVitaConfiguration)
    {
        var data:Data = Data()
        
        data.append(value:configuration.storageId)
        data.append(value:directory.format.rawValue)
        data.append(value:configuration.storageProtectionStatus)
        
        self.data = data
    }
}
