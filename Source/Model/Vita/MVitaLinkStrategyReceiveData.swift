import Foundation

class MVitaLinkStrategyReceiveData:MVitaLinkStrategyProtocol
{
    var data:Data
    var payload:Int
    private(set) var model:MVitaLink?
    
    init(model:MVitaLink)
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
        guard
            
            let requestVitaInfo:MVitaPtpMessageInRequestVitaInfo = MVitaPtpMessageInRequestVitaInfo(
                header:header,
                data:data),
            header.type == MVitaPtpType.dataPacketStart,
            requestVitaInfo.payload > 0
            
            else
        {
            failed()
            
            return
        }
        
        success()
    }
    
    //MARK: private
    
    
}
