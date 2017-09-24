import Foundation

final class MVitaLink
{
    weak var delegate:MVitaLinkDelegate?
    var strategy:MVitaLinkStrategyProtocol?
    let device:MVitaDevice
    let configuration:MVitaConfiguration
    let linkCommand:MVitaLinkSocketCommand
    let linkEvent:MVitaLinkSocketEvent
    var vitaInfo:MVitaInfo?
    var vitaCapabilities:MVitaCapabilities?
    var vitaSettings:MVitaSettings?
    var log:[MVitaLinkLogProtocol]
    
    init(
        device:MVitaDevice,
        configuration:MVitaConfiguration,
        delegate:MVitaLinkDelegate?)
    {
        self.device = device
        self.configuration = configuration
        self.delegate = delegate
        linkCommand = MVitaLink.factorySocketCommand()
        linkEvent = MVitaLink.factorySocketEvent()
        log = []
        
        linkCommand.model = self
        linkEvent.model = self
        
        changeStrategy(strategyType:
            MVitaLinkStrategyOff.self)
    }
}
