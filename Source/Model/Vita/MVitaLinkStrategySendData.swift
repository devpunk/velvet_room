import Foundation

class MVitaLinkStrategySendData:MVitaLinkStrategyProtocol
{
    var data:Data
    var payload:Int
    var transactionId:UInt32
    private(set) var model:MVitaLink?
    private let kElementsStart:Int = 2
    
    required init(model:MVitaLink)
    {
        self.model = model
        data = Data()
        payload = 0
        transactionId = 0
    }
    
    //MARK: protocol
    
    
    //MARK: internal
    
    final func send(data:Data, code:UInt16)
    {
        
    }
    
    func failed() { }
    func success() { }
}
