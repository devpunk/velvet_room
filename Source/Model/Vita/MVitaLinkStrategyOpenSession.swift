import Foundation

final class MVitaLinkStrategyOpenSession:MVitaLinkStrategyProtocol
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
            
            let confirm:MVitaPtpMessageInConfirm = MVitaPtpMessageInConfirm(
                header:header,
                data:data),
            header.type == MVitaPtpType.commandAccepted,
            confirm.code == MVitaPtpCommand.success
            
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
        model?.errorCloseConnection(
            message:message)
    }
    
    private func success()
    {
        model?.requestVitaInfo()
    }
}
