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
        message:MVitaPtpMessageInEvent)
    {
        changeStrategy(strategyType:
            MVitaLinkStrategyRequestSettings.self)
        linkCommand.requestSettings(message:message)
    }
    
    //MARK: internal
    
    func receivedEvent(message:MVitaPtpMessageInEvent)
    {
        switch message.code
        {
        case MVitaPtpEvent.requestSettings:
            
            requestSettings(message:message)
            
            break
            
        default:
            
            unknownEventReceived()
            
            break
        }
    }
}
