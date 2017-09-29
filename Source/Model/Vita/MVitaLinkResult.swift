import Foundation

extension MVitaLink
{
    //MARK: internal
    
    func sendResultSuccess(
        event:MVitaPtpMessageInEvent)
    {
        changeStrategy(strategyType:
            MVitaLinkStrategySendResult.self)
        linkCommand.sendResult(
            event:event,
            result:MVitaPtpResult.success)
    }
    
    func sendResult(
        vitaSettings:MVitaSettings,
        event:MVitaPtpMessageInEvent)
    {
        self.vitaSettings = vitaSettings
        sendResultSuccess(event:event)
    }
    
    func sendResult(
        vitaItem:MVitaItemIn,
        event:MVitaPtpMessageInEvent)
    {
        sendResultSuccess(event:event)
        
        guard
            
            let database:Database = self.database
        
        else
        {
            return
        }
        
        storeItem(
            vitaItem:vitaItem,
            database:database)
        {
                
        }
    }
}
