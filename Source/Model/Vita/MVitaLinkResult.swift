import Foundation

extension MVitaLink
{
    //MARK: private
    
    private func storeAndLog(
        vitaItem:MVitaItemInDirectory,
        database:Database)
    {
        MVitaLink.storeItem(
            vitaItem:vitaItem,
            database:database)
        { [weak self] (directory:DVitaItemDirectory) in
            
            self?.logRequestItem(directory:directory)
        }
    }
    
    //MARK: internal
    
    func sendResultSuccess(
        event:MVitaPtpMessageInEvent,
        parameters:[UInt32])
    {
        changeStrategy(strategyType:
            MVitaLinkStrategySendResult.self)
        linkCommand.sendResult(
            event:event,
            result:MVitaPtpResult.success,
            parameters:parameters)
    }
    
    func sendResult(
        vitaSettings:MVitaSettings,
        event:MVitaPtpMessageInEvent)
    {
        self.vitaSettings = vitaSettings
        sendResultSuccess(
            event:event,
            parameters:[])
    }
    
    func sendResult(
        vitaItem:MVitaItemInDirectory,
        event:MVitaPtpMessageInEvent)
    {
        sendResultSuccess(
            event:event,
            parameters:[])
        
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
