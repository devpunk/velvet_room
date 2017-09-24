import Foundation

extension MVitaLink
{
    //MARK: internal
    
    func sendResult(
        vitaSettings:MVitaSettings,
        event:MVitaPtpMessageInEvent)
    {
        self.vitaSettings = vitaSettings
        
        changeStrategy(strategyType:
            MVitaLinkStrategySendResult.self)
        linkCommand.sendResult(
            event:event,
            result:MVitaPtpResult.success)
    }
}
