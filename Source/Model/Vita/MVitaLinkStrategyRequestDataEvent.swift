import Foundation

class MVitaLinkStrategyRequestDataEvent:
    MVitaLinkStrategyRequestData,
    MVitaLinkStrategyEventProtocol
{
    private var event:MVitaPtpMessageInEvent?
    
    //MARK: event protocol
    
    final func config(event:MVitaPtpMessageInEvent)
    {
        self.event = event
    }
}
