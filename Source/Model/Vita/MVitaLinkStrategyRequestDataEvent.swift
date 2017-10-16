import Foundation

class MVitaLinkStrategyRequestDataEvent:
    MVitaLinkStrategyRequestData,
    MVitaLinkStrategyEventProtocol
{
    private(set) var event:MVitaPtpMessageInEvent?
    
    //MARK: event protocol
    
    final func config(event:MVitaPtpMessageInEvent)
    {
        self.event = event
    }
}
