import Foundation

final class MVitaLinkStrategySendItemThumbnail:
    MVitaLinkStrategySendData,
    MVitaLinkStrategyEventProtocol
{
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
        
        model?.sendResultSuccess(
            event:event,
            parameters:[])
    }
    
    //MARK: event protocol
    
    func config(event:MVitaPtpMessageInEvent)
    {
        print("requesting thumbnail \(event.parameters)")
        
        self.event = event
        
        guard
        
            let handles:MVitaPtpMessageInEventHandles = MVitaPtpMessageInEventHandles.factoryHandles(
                event:event)
        
        else
        {
            failed()
            
            return
        }
        
        let itemIndex:Int = Int(handles.item)
        findDirectory(
            event:event,
            itemIndex:itemIndex)
    }
    
    //MARK: private
    
    private func findDirectory(
        event:MVitaPtpMessageInEvent,
        itemIndex:Int)
    {
        model?.directoryAtPosition(itemIndex:itemIndex)
        { [weak self] (directory:DVitaItemDirectory?) in
            
            guard
                
                let directory:DVitaItemDirectory = directory
                
            else
            {
                self?.failed()
                
                return
            }
            
            self?.sendThumbnail(
                directory:directory,
                event:event)
        }
    }
    
    private func sendThumbnail(
        directory:DVitaItemDirectory,
        event:MVitaPtpMessageInEvent)
    {
        MVitaXmlThumbnail.factoryMetadata(directory:directory)
        { (data:Data?) in
            
            guard
            
                let data:Data = data
            
            else
            {
                self.failed()
                
                return
            }
            
            self.sendData(
                data:data,
                event:event)
        }
    }
    
    private func sendData(
        data:Data,
        event:MVitaPtpMessageInEvent)
    {
        let message:MVitaPtpMessageOutEventCommand = MVitaPtpMessageOutEventCommand(
            event:event,
            dataPhase:MVitaPtpDataPhase.send,
            command:MVitaPtpCommand.sendItemThumbnail)
        
        send(
            data:data,
            message:message)
    }
}
