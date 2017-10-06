import Foundation

extension MVitaLinkStrategySendItem
{
    func directoryFound(
        directory:DVitaItemDirectory,
        handles:MVitaPtpMessageInEventHandles)
    {
        guard
            
            let elements:[
            DVitaItemElement] = directory.elements?.array as? [
                DVitaItemElement]
            
        else
        {
            failed()
            
            return
        }
        
        self.elements = elements
        
        sendDirectory(
            directory:directory,
            handles:handles)
    }
    
    private func sendDirectory(
        directory:DVitaItemDirectory,
        handles:MVitaPtpMessageInEventHandles)
    {
        guard
            
            let configuration:MVitaConfiguration = model?.configuration,
            let directoryPacked:MVitaPtpPackDirectory = MVitaPtpPackDirectory(
                directory:directory,
                configuration:configuration,
                parentHandle:handles.parent)
            
        else
        {
            failed()
            
            return
        }
        
        let message:MVitaPtpMessageOutSendItem = MVitaPtpMessageOutSendItem(
            storageId:configuration.storage.storageId,
            parentHandle:handles.parent)
        
        send(
            data:directoryPacked.data,
            message:message)
    }
    
    //MARK: internal
    
    func findDirectory(
        handles:MVitaPtpMessageInEventHandles)
    {
        let itemIndex:Int = Int(handles.item)
        
        model?.directoryAtPosition(itemIndex:itemIndex)
        { [weak self] (directory:DVitaItemDirectory?) in
            
            guard
                
                let directory:DVitaItemDirectory = directory
                
            else
            {
                self?.failed()
                
                return
            }
            
            self?.directoryFound(
                directory:directory,
                handles:handles)
        }
    }
}
