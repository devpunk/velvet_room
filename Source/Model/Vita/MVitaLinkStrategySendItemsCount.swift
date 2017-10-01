import Foundation

final class MVitaLinkStrategySendItemsCount:
    MVitaLinkStrategySendData,
    MVitaLinkStrategyEventProtocol
{
    private var event:MVitaPtpMessageInEvent?
    
    override func failed()
    {
        let message:String = String.localizedModel(
            key:"MVitaLinkStrategySendItemsCount_messageFailed")
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
    
    func config(event:MVitaPtpMessageInEvent)
    {
//        self.event = event
//
//        let data:Data = factoryData()
//        let message:MVitaPtpMessageOutEventCommand = MVitaPtpMessageOutEventCommand(
//            event:event,
//            dataPhase:MVitaPtpDataPhase.send,
//            command:MVitaPtpCommand.sendStorageSize)
//
//        send(
//            data:data,
//            message:message)
    }
    
    //MARK: private
    
}
