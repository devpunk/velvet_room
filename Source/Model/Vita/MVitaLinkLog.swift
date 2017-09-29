import Foundation

extension MVitaLink
{
    //MARK: private
    
    private func addToLog(
        logItem:MVitaLinkLogProtocol)
    {
        log.append(logItem)
        
        DispatchQueue.global(
            qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.delegate?.vitaLinkLogUpdated()
        }
    }
    
    //MARK: internal
    
    func logConnectionReady()
    {
        let logItem:MVitaLinkLogSystem = MVitaLinkLogSystem(
            systemType:MVitaLinkLogSystemType.connectionStart)
        
        addToLog(logItem:logItem)
    }
    
    func logRequestItem(
        vitaItem:MVitaItemIn)
    {
//        let logItem:MVitaLinkLogGameSave = MVitaLinkLogGameSave(
//            transferType:MVitaLinkLogTransferType.request,
//            image:im,
//            gameName: <#T##String#>)
    }
}
