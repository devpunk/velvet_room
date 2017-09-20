import Foundation

final class MVitaPtpMessageInRequestCommand:MVitaPtpMessageIn
{
    let eventPipeId:UInt32
    
    override init?(
        header:MVitaPtpMessageInHeader,
        data:Data)
    {
        let arrayData:[UInt32] = data.withUnsafeBytes
        { (pointer:UnsafePointer<UInt32>) -> [UInt32] in
            
            let bufferPointer:UnsafeBufferPointer = UnsafeBufferPointer(
                start:pointer,
                count:1)
            let array:[UInt32] = Array(bufferPointer)
            
            return array
        }
        
        guard
            
            let eventPipeId:UInt32 = arrayData.first
            
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
