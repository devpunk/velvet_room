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
}
