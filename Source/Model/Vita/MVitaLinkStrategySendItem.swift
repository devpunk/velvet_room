import Foundation

final class MVitaLinkStrategySendItem:
    MVitaLinkStrategySendData,
    MVitaLinkStrategyEventProtocol
{
    var elements:[DVitaItemElement]?
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
            
            self?.directoryReceived(
                directory:directory,
                event:event)
        }
    }
}
