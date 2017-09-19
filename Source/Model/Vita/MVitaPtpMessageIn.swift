import Foundation

class MVitaPtpMessageIn
{
    let header:MVitaPtpMessageInHeader
    
    init(
        header:MVitaPtpMessageInHeader,
        data:Data)
    {
        self.header = header
    }
}
