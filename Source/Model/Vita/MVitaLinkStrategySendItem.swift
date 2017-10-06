import Foundation

final class MVitaLinkStrategySendItem:
    MVitaLinkStrategySendData,
    MVitaLinkStrategyEventProtocol
{
    var elements:[DVitaItemElement]?
    private(set) var handles:MVitaPtpMessageInEventHandles?
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
        sendNextElement()
    }
    
    //MARK: internal
    
    func sendCompleted()
    {
        print("send completed")
        //model?.sendResultSuccess(event:)
    }
    
    //MARK: event protocol
    
    func config(event:MVitaPtpMessageInEvent)
    {
        self.event = event
        
        guard
            
            let handles:MVitaPtpMessageInEventHandles = MVitaPtpMessageInEventHandles.factoryHandles(
                event:event)
        
        else
        {
            failed()
            
            return
        }
        
        self.handles = handles
        findDirectory(handles:handles)
    }
}
