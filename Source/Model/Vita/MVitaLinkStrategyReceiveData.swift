import Foundation

class MVitaLinkStrategyReceiveData:MVitaLinkStrategyProtocol
{
    var data:Data
    var payload:Int
    private(set) var model:MVitaLink?
    
    required init(model:MVitaLink)
    {
        self.model = model
        data = Data()
        payload = 0
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
    
    //MARK: internal
    
    func failed()
    {
    }
    
    func success()
    {
    }
}
