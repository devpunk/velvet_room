import Foundation

struct MVitaPtpPackElement:MVitaPtpPackProtocol
{
    let data:Data
    
    init?(
        element:DVitaItemElement,
        configuration:MVitaConfiguration,
        parentHandle:UInt32)
    {
        guard
            
            let name:String = element.name,
            let data:Data = MVitaPtpPackDirectory.factoryPack(
                configuration:configuration,
                parentHandle:parentHandle,
                name:name,
                format:element.format,
                size:element.size)
            
        else
        {
            return nil
        }
        
        self.data = data
    }
}
