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
        
        self.data = data
    }
}
