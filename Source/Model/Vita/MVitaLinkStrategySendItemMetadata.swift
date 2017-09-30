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
    }
    
    //MARK: event protocol
    
    func config(item:DVitaItem)
    {
        self.item = item
    }
    
    func config(event:MVitaPtpMessageInEvent)
    {
        self.event = event
        
        guard
        
            let item:DVitaItemExportProtocol = self.item as? DVitaItemExportProtocol,
            let event:MVitaPtpMessageInEvent = self.event
        
        else
        {
            failed()
            
            return
        }
        
        export(item:item, event:event)
    }
    
    //MARK: private
    
    private func export(
        item:DVitaItemExportProtocol,
        event:MVitaPtpMessageInEvent)
    {
        item.export
        { [weak self] (data:Data?) in
            
            guard
                
                let data:Data = data
                
            else
            {
                self?.failed()
                
                return
            }
            
            self?.sendData(
                data:data,
                event:event)
        }
    }
    
    private func sendData(
        data:Data,
        event:MVitaPtpMessageInEvent)
    {
        let wrappedData:Data = MVitaLink.wrapDataWithSizeHeader(
            data:data)
        
        let message:MVitaPtpMessageOutEventCommand = MVitaPtpMessageOutEventCommand(
            event:event,
            dataPhase:MVitaPtpDataPhase.send,
            command:MVitaPtpCommand.sendItemMetadata)
        
        send(
            data:wrappedData,
            message:message)
    }
}
