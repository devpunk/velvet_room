import Foundation

struct MVitaPtpPackDirectory:MVitaPtpPackProtocol
{
    let data:Data
    
    init?(
        directory:DVitaItemDirectory,
        configuration:MVitaConfiguration,
        parentHandle:UInt32)
    {
        print("dire \(directory.identifier!.identifier!) \(parentHandle) format \(directory.format)")
        guard
            
            let name:String = directory.identifier?.identifier,
            let data:Data = MVitaPtpPackDirectory.factoryPack(
                configuration:configuration,
                parentHandle:parentHandle,
                name:name,
                format:directory.format,
                size:0)
        
        else
        {
            return nil
        }
        
        self.data = data
    }
}
