import Foundation

final class MVitaLinkStrategyRequestVitaInfo:MVitaLinkStrategyProtocol
{
    private(set) var model:MVitaLink?
    
    init(model:MVitaLink)
    {
        self.model = model
    }
    
    //MARK: protocol
    
    func commandReceived(
        header:MVitaPtpMessageInHeader,
        data:Data)
    {
        guard
            
            let openSession:MVitaPtpMessageInOpenSession = MVitaPtpMessageInOpenSession(
                header:header,
                data:data),
            header.type == MVitaPtpType.commandAccepted,
            openSession.code == MVitaPtpCommand.success
            
        else
        {
            failed()
            
            return
        }
        
        success()
    }
    
    //MARK: private
    
    private func failed()
    {
        let message:String = String.localizedModel(
            key:"MVitaLinkStrategyOpenSession_messageFailed")
        model?.delegate?.linkError(message:message)
    }
    
    private func success()
    {
        model?.requestVitaInfo()
    }
}
