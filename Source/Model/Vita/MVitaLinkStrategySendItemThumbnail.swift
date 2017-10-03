import Foundation

final class MVitaLinkStrategySendItemThumbnail:
    MVitaLinkStrategySendData,
    MVitaLinkStrategyEventProtocol,
    MVitaLinkStrategyItemsProtocol
{
    private var items:[DVitaItem]?
    private var event:MVitaPtpMessageInEvent?
    
    override func failed()
    {
        let message:String = String.localizedModel(
            key:"MVitaLinkStrategySendItemThumbnail_messageFailed")
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
    
    func config(items:[DVitaItem])
    {
        self.items = items
    }
    
    func config(event:MVitaPtpMessageInEvent)
    {
        self.event = event
        
        guard
            
            let items:[DVitaItem] = self.items
            
        else
        {
            failed()
            
            return
        }
        
        MVitaXmlItem.factoryMetadata(
            items:items)
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
    
    //MARK: private
    
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