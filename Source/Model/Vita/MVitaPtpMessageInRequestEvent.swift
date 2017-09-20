import Foundation

final class MVitaPtpMessageInRequestEvent:MVitaPtpMessageIn
{
    let eventPipeId:UInt32
    
    override init?(
        header:MVitaPtpMessageInHeader,
        data:Data)
    {
        guard
            
            let eventPipeId:UInt32 = data.valueFromBytes()
            
        else
        {
            return nil
        }
        
        self.eventPipeId = eventPipeId
        
        super.init(
            header:header,
            data:data)
    }
}
