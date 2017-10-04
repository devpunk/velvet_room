import Foundation

final class MVitaLinkStrategySendItem:
    MVitaLinkStrategySendData,
    MVitaLinkStrategyEventProtocol
{
    private var event:MVitaPtpMessageInEvent?
    
    override func failed()
    {
        let message:String = String.localizedModel(
            key:"MVitaLinkStrategySendItem_messageFailed")
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
        
        print("event success params :\(event.parameters)")
        
//        model?.sendResultSuccess(event:event)
    }
    
    //MARK: event protocol
    
    func config(event:MVitaPtpMessageInEvent)
    {
        self.event = event
        
        model?.directoryAtEventPosition(event:event)
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
    
    //MARK: private
    
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
