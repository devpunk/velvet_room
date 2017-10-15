import Foundation

final class MConnected:
    Model<ArchConnected>,
    MVitaLinkDelegate
{
    var status:MConnectedStatusProtocol?
    var vitaLink:MVitaLink?
    var events:[MConnectedEventProtocol]
    
    required init()
    {
        events = []
        
        super.init()
        
        statusOn()
    }
    
    deinit
    {
        cancelAndClean()
    }
}
