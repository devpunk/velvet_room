import Foundation

final class MConnected:
    Model<ArchConnected>,
    MVitaLinkDelegate
{
    var status:MConnectedStatusProtocol?
    var vitaLink:MVitaLink?
    
    required init()
    {
        super.init()
        
        statusOn()
    }
}
