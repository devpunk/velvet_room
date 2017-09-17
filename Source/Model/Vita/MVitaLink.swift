import Foundation

final class MVitaLink
{
    weak var delegate:MVitaLinkDelegate?
    let device:MVitaDevice
    let configuration:MVitaConfiguration
    
    init(
        device:MVitaDevice,
        configuration:MVitaConfiguration,
        delegate:MVitaLinkDelegate?)
    {
        self.device = device
        self.configuration = configuration
        self.delegate = delegate
    }
}
