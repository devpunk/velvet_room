import Foundation

final class MVitaLinkStrategySendItemsCount:
    MVitaLinkStrategyProtocol,
    MVitaLinkStrategyEventProtocol
    MVitaLinkStrategyDatabaseProtocol,
{
    private(set) var model:MVitaLink?
    private var event:MVitaPtpMessageInEvent?
    
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
            key:"MVitaLinkStrategySendItemsCount_messageFailed")
        model?.errorCloseConnection(
            message:message)
    }
    
    private func success()
    {
        guard
            
            let event:MVitaPtpMessageInEvent = self.event
            
        else
        {
            failed()
            
            return
        }
        
        model?.sendResultSuccess(event:event)
    }
    
    //MARK: event protocol
    
    func config(event:MVitaPtpMessageInEvent)
    {
        
    }
    
    //MARK: private
    
    private func send(
        event:MVitaPtpMessageInEvent,
        count:Int)
    {
        let message:MVitaPtpMessageOutItemsCount = MVitaPtpMessageOutItemsCount(
            event:event,
            count:count)
        model?.linkCommand.writeMessage(
            message:message)
    }
}
