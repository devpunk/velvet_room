import Foundation

class MVitaPtpMessageIn
{
    let header:MVitaPtpMessageInHeader
    
    init?(data:Data)
    {
        guard
        
            let header:MVitaPtpMessageInHeader = MVitaPtpMessageIn.factoryHeader(
                data:data)
        
        else
        {
            return nil
        }
        
        self.header = header
    }
}
