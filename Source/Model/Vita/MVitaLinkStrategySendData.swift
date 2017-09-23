import Foundation

class MVitaLinkStrategySendData:MVitaLinkStrategyProtocol
{
    var data:Data
    var payload:Int
    var transactionId:UInt32
    private(set) var model:MVitaLink?
    private(set) var status:MVitaLinkStrategySendDataStatusProtocol?
    private let kElementsStart:Int = 2
    
    required init(model:MVitaLink)
    {
        self.model = model
        data = Data()
        payload = 0
        transactionId = 0
        changeStatus(
            status:MVitaLinkStrategySendDataStatusHeader.self)
    }
    
    //MARK: protocol
    
    func commandWrite()
    {
        status?.commandWrite(strategy:self)
    }
    
    //MARK: private
    
    private func changeStatus(
        status:MVitaLinkStrategySendDataStatusProtocol.Type)
    {
        self.status = status.init()
    }
    
    //MARK: internal
    
    final func send(
        data:Data,
        code:UInt16)
    {
        let message:MVitaPtpMessageOutSendData = MVitaPtpMessageOutSendData(
            code:code)
        model?.linkCommand.writeMessage(
            message:message)
    }
    
    final func packetStart()
    {
        changeStatus(
            status:MVitaLinkStrategySendDataStatusPacketStart.self)
    }
    
    func failed() { }
    func success() { }
}
