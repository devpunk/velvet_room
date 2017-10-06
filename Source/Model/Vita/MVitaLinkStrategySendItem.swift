import Foundation

final class MVitaLinkStrategySendItem:
    MVitaLinkStrategySendData,
    MVitaLinkStrategyEventProtocol
{
    var elements:[DVitaItemElement]?
    private(set) var handles:MVitaPtpMessageInEventHandles?
    private var event:MVitaPtpMessageInEvent?
    private var status:MVitaLinkStrategySendItemProtocol?
    
    override func failed()
    {
        let message:String = String.localizedModel(
            key:"MVitaLinkStrategySendItem_messageFailed")
        model?.errorCloseConnection(
            message:message)
    }
    
    override func success()
    {
        print("success \(status)")
        status?.nextStep(strategy:self)
    }
    
    //MARK: internal
    
    func changeStatus(
        statusType:MVitaLinkStrategySendItemProtocol.Type)
    {
        let status:MVitaLinkStrategySendItemProtocol = statusType.init()
        self.status = status
    }
    
    func sendCompleted()
    {
        print("send completed")
        
        guard
        
            let event:MVitaPtpMessageInEvent = self.event,
            let handles:MVitaPtpMessageInEventHandles = self.handles
        
        else
        {
            return
        }
        
        let parameters:[UInt32] = [
            handles.parent]
        
        model?.sendResultSuccess(
            event:event,
            parameters:parameters)
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
        changeStatus(
            statusType:MVitaLinkStrategySendItemDirectoryInfo.self)
        findDirectory(handles:handles)
    }
}
