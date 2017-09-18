import Foundation

final class MHome:Model<ArchHome>
{
    var database:Database?
    var account:DAccount?
    
    required init()
    {
        super.init()
        
        let message:MVitaPtpMessage = MVitaPtpMessage()
        let data:Data = message.data
        
        let array:[UInt32] = data.withUnsafeBytes
        {
            
            Array(UnsafeBufferPointer<UInt32>(start: $0, count:1))
        }
        
        print(array[0])
    }
    
    func factoryPtp() -> MVitaPtpMessage
    {
        let firstVal:UInt32 = 55
        
        let message:MVitaPtpMessage = MVitaPtpMessage()
        message.append(value:firstVal)
        
        return message
    }
}
