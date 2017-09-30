import Foundation

final class MVitaLinkStrategySendItemMetadata:
    MVitaLinkStrategySendData,
    MVitaLinkStrategyEventProtocol,
    MVitaLinkStrategyItemProtocol
{
    private var item:DVitaItem?
    private var event:MVitaPtpMessageInEvent?
    
    override func failed()
    {
        let message:String = String.localizedModel(
            key:"MVitaLinkStrategySendItemMetadata_messageFailed")
        model?.errorCloseConnection(
            message:message)
    }
    
    override func success()
    {
        guard
            
            let event:MVitaPtpMessageInEvent = self.event
            
        else
        {
            failed()
            
            return
        }
        
        model?.sendResultSuccess(event:event)
        print("metadata sent")
    }
    
    //MARK: event protocol
    
    func config(item:DVitaItem)
    {
        self.item = item
    }
    
    func config(event:MVitaPtpMessageInEvent)
    {
        self.event = event
        
        let data:Data = factoryData()
        let message:MVitaPtpMessageOutEventCommand = MVitaPtpMessageOutEventCommand(
            event:event,
            dataPhase:MVitaPtpDataPhase.send,
            command:MVitaPtpCommand.sendStorageSize)
        
        send(
            data:data,
            message:message)
    }
    
    //MARK: private
    
    private func factoryData() -> Data
    {
        var data:Data = Data()
        
        return data
    }
}
