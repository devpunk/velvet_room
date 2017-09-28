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
        let log2:MVitaLinkLogProtocol = MVitaLinkLogGameSave(
            transferType:MVitaLinkLogTransferType.request,
            image:#imageLiteral(resourceName: "Persona_2_EP_cover"),
            gameName:"Persona 2 Eternal Punishment")
        let log3:MVitaLinkLogProtocol = MVitaLinkLogGameSave(
            transferType:MVitaLinkLogTransferType.send,
            image:#imageLiteral(resourceName: "Persona_2_EP_cover"),
            gameName:"Persona 2 Eternal Punishment")
        let logs:[MVitaLinkLogProtocol] = [
            log1,
            log2,
            log3,
            log1]
//        updateEvents(logs:logs)
//        foundError(errorMessage:"PS Vita not found,\ntry again")
    }
    
    deinit
    {
        cancelAndClean()
    }
}
