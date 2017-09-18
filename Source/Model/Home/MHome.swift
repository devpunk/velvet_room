import Foundation

final class MHome:Model<ArchHome>
{
    var database:Database?
    var account:DAccount?
    
    required init()
    {
        super.init()
        
        let message:MVitaPtpMessageOut = factoryPtp()
        let data:Data = message.export()
        print("size \(data.count)")
        
        let array:[UInt32] = data.withUnsafeBytes
        {
            
            Array(UnsafeBufferPointer<UInt32>(start: $0, count:2))
        }
        
        print(array)
    }
    
    func factoryPtp() -> MVitaPtpMessageOut
    {
        let firstVal:UInt32 = 55
        
        let message:MVitaPtpMessageOut = MVitaPtpMessageOut()
        message.append(value:firstVal)
        
        return message
    }
}
