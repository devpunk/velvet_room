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
        
        //MARK: MOCK
        
        let log1:MVitaLinkLogProtocol = MVitaLinkLogSystem(
            systemType:MVitaLinkLogSystemType.connectionStart)
        let logs:[MVitaLinkLogProtocol] = [
            log1]
        updateEvents(logs:logs)
    }
    
    deinit
    {
        cancelAndClean()
    }
}
