import Foundation

final class MVitaLink
{
    weak var delegate:MVitaLinkDelegate?
    let device:MVitaDevice
    let configuration:MVitaConfiguration
    let linkCommand:MVitaLinkCommand
    let linkEvent:MVitaLinkEvent
    
    init(
        device:MVitaDevice,
        configuration:MVitaConfiguration,
        delegate:MVitaLinkDelegate?)
    {
        self.device = device
        self.configuration = configuration
        self.delegate = delegate
        
        linkCommand = MVitaLink.factoryLinkCommand()
        linkEvent = MVitaLink.factoryLinkEvent()
    }
}
