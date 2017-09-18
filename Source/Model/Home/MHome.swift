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
        
        let messageIn:MVitaPtpMessageIn? = MVitaPtpMessageIn(data:data)
        
        print("\(messageIn?.header.size) \(messageIn?.header.type)")
    }
    
    func factoryPtp() -> MVitaPtpMessageOut
    {
        let firstVal:UInt32 = 55
        
        let message:MVitaPtpMessageOut = MVitaPtpMessageOut()
        message.append(value:firstVal)
        
        return message
    }
}
