import Foundation

final class MHome:Model<ArchHome>
{
    var database:Database?
    var account:DAccount?
    
    required init()
    {
        super.init()
        
        let message:MVitaPtpMessageOutProtocol = MVitaPtpMessageOutCommandRequest()
        
        let messageIn:MVitaPtpMessageIn? = MVitaPtpMessageIn(data:message.data)
        
        print("\(messageIn?.header.size) \(messageIn?.header.type)")
    }
}
