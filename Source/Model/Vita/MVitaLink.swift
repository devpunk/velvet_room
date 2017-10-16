import Foundation

final class MVitaLink
{
    weak var delegate:MVitaLinkDelegate?
    var log:[MVitaLinkLogProtocol]
    var database:Database?
    var strategy:MVitaLinkStrategyProtocol?
    let device:MVitaDevice
    let configuration:MVitaConfiguration
    let linkCommand:MVitaLinkSocketCommand
    let linkEvent:MVitaLinkSocketEvent
    var vitaInfo:MVitaInfo?
    var vitaCapabilities:MVitaCapabilities?
    var vitaSettings:MVitaSettings?
    
    init(
        device:MVitaDevice,
        configuration:MVitaConfiguration,
        delegate:MVitaLinkDelegate?)
    {
        self.device = device
        self.configuration = configuration
        self.delegate = delegate
        log = []
        database = Database(bundle:nil)
        linkCommand = MVitaLink.factorySocketCommand()
        linkEvent = MVitaLink.factorySocketEvent()
        
        linkCommand.model = self
        linkEvent.model = self
        
        changeStrategy(strategyType:
            MVitaLinkStrategyOff.self)
    }
}
