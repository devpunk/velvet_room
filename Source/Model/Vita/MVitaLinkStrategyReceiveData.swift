import Foundation

class MVitaLinkStrategyReceiveData:MVitaLinkStrategyProtocol
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
    
    func commandReceived(
        header:MVitaPtpMessageInHeader,
        data:Data)
    {
        switch header.type
        {
        case MVitaPtpType.dataPacketStart:
            
            receivedPacketStart(
                header:header,
                data:data)
            
            break
            
        case MVitaPtpType.dataPacket:
            
            receivedPacket(
                header:header,
                data:data)
            
            break
            
        case MVitaPtpType.dataPacketEnd:
            
            receivedPacketEnd(
                header:header,
                data:data)
            
            break
            
        case MVitaPtpType.commandAccepted:
            
            receivedConfirm(
                header:header,
                data:data)
            
            break
            
        default:
            
            failed()
            
            break
        }
    }
    
    //MARK: private
    
    private func receivedPacketStart(
        header:MVitaPtpMessageInHeader,
        data:Data)
    {
        guard
            
            let arrayData:[UInt32] = data.arrayFromBytes(
                elements:kElementsStart),
            let transactionId:UInt32 = arrayData.first,
            let payloadUnsigned:UInt32 = arrayData.last
            
        else
        {
            failed()
            
            return
        }
        
        self.transactionId = transactionId
        payload = Int(payloadUnsigned)
    }
    
    private func receivedPacket(
        header:MVitaPtpMessageInHeader,
        data:Data)
    {
        
    }
    
    private func receivedPacketEnd(
        header:MVitaPtpMessageInHeader,
        data:Data)
    {
        
    }
    
    private func receivedConfirm(
        header:MVitaPtpMessageInHeader,
        data:Data)
    {
        
    }
    
    //MARK: internal
    
    func failed()
    {
    }
    
    func success()
    {
    }
}
