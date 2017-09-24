import Foundation

final class MVitaLinkStrategyRequestCommand:MVitaLinkStrategyProtocol
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
            failed()
            
            return
        }
        
        success(requestCommand:requestCommand)
    }
    
    //MARK: private
    
    private func failed()
    {
        let message:String = String.localizedModel(
            key:"MVitaLinkStrategyRequestCommand_messageFailed")
        model?.delegate?.vitaLinkError(message:message)
    }
    
    private func success(
        requestCommand:MVitaPtpMessageInRequestCommand)
    {
        model?.requestEvent(requestCommand:requestCommand)
    }
}
