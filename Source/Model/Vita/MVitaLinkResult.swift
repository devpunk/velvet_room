import Foundation

extension MVitaLink
{
    //MARK: private
    
    private func storeAndLog(
        vitaItem:MVitaItemInDirectory,
        database:Database)
    {
        storeItem(
            vitaItem:vitaItem,
            database:database)
        { [weak self] in
            
            self?.logRequestItem(
                vitaItem:vitaItem)
        }
    }
    
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
        vitaItem:MVitaItemInDirectory,
        event:MVitaPtpMessageInEvent)
    {
        sendResultSuccess(event:event)
        
        guard
            
            let database:Database = self.database
        
        else
        {
            return
        }
        
        storeAndLog(
            vitaItem:vitaItem,
            database:database)
    }
}
