import UIKit

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
    
    private func asyncLogRequestItem(
        directory:DVitaItemDirectory)
    {/*
        guard
            
            let name:String = directory.sfoTitle,
            let localName:String = directory.localName,
            let thumbnail:Data = MVitaLink.thumbnail(
                directoryName:localName),
            let image:UIImage = UIImage(
                data:thumbnail)
            
        else
        {
            return
        }
        
        let logItem:MVitaLinkLogGameSave = MVitaLinkLogGameSave(
            transferType:MVitaLinkLogTransferType.request,
            image:image,
            gameName:name)
        addToLog(logItem:logItem)*/
    }
    
    //MARK: internal
    
    func logConnectionReady()
    {
        let logItem:MVitaLinkLogSystem = MVitaLinkLogSystem(
            systemType:MVitaLinkLogSystemType.connectionStart)
        
        addToLog(logItem:logItem)
    }
    
    func logRequestItem(
        directory:DVitaItemDirectory)
    {
        DispatchQueue.global(
            qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncLogRequestItem(
                directory:directory)
        }
    }
}
