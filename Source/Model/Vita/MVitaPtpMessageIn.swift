import Foundation

class MVitaPtpMessageIn
{
    let header:MVitaPtpMessageInHeader
    
    init?(data:Data)
    {
        guard
        
            let header:MVitaPtpMessageInHeader = MVitaPtpMessageInHeader(
                data:data)
        
        else
        {
            return nil
        }
        
        self.header = header
    }
}
