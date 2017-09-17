import Foundation

final class MVitaLink
{
    weak var delegate:MVitaLinkDelegate?
    let device:MVitaDevice
    let configuration:MVitaConfiguration
    let linkCommand:MVitaLinkCommand
    let linkEvent:MVitaLinkEvent
    
    init?(
        device:MVitaDevice,
        configuration:MVitaConfiguration,
        delegate:MVitaLinkDelegate?)
    {
        guard
            
            let linkCommand:MVitaLinkCommand = MVitaLink.factoryLinkCommand(),
            let linkEvent:MVitaLinkEvent = MVitaLink.factoryLinkEvent()
        
        else
        {
            return nil
        }
        
        self.linkCommand = linkCommand
        self.linkEvent = linkEvent
        self.device = device
        self.configuration = configuration
        self.delegate = delegate
        
        linkCommand.model = self
        linkEvent.model = self
    }
}
