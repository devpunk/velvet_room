import Foundation

extension MVitaLink
{
    //MARK: private
    
    private func unknownEventReceived()
    {
        let message:String = String.localizedModel(
            key:"MVitaLink_unknownEventReceived")
        delegate?.linkError(message:message)
    }
    
    private func requestSettings(
        event:MVitaPtpMessageInEvent)
    {
        changeStrategy(strategyType:
            MVitaLinkStrategyRequestSettings.self)
        linkCommand.requestSettings(event:event)
    }
    
    //MARK: internal
    
    func receivedEvent(event:MVitaPtpMessageInEvent)
    {
        switch event.code
        {
        case MVitaPtpEvent.requestSettings:
            
            requestSettings(event:event)
            
            break
            
        default:
            
            unknownEventReceived()
            
            break
        }
    }
}
