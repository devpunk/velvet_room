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
            
            let requestCommand:MVitaPtpMessageInRequestCommand = MVitaPtpMessageInRequestCommand(
                header:header,
                data:data),
            header.type == MVitaPtpType.commandRequestAccepted
            
        else
        {
            return
        }
        
        success(requestCommand:requestCommand)
    }
    
    //MARK: private
    
    private func failed()
    {
        let message:String = String.localizedModel(
            key:"MVitaLinkStrategyRequestCommand_messageFailed")
        model?.delegate?.linkError(message:message)
    }
    
    private func success(
        requestCommand:MVitaPtpMessageInRequestCommand)
    {
        model?.requestEvent(requestCommand:requestCommand)
    }
}