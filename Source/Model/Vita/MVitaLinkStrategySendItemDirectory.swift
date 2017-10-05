import Foundation

extension MVitaLinkStrategySendItem
{
    private func sendDirectory(
        directory:DVitaItemDirectory,
        event:MVitaPtpMessageInEvent)
    {
        guard
            
            let handle:UInt32 = event.parameters.first,
            let configuration:MVitaConfiguration = model?.configuration,
            let directoryPacked:MVitaPtpPackDirectory = MVitaPtpPackDirectory(
                directory:directory,
                configuration:configuration,
                handle:handle)
            
        else
        {
            failed()
            
            return
        }
        
        let message:MVitaPtpMessageOutSendItem = MVitaPtpMessageOutSendItem(
            storageId:configuration.storageId,
            handle:handle)
        
        send(
            data:directoryPacked.data,
            message:message)
    }
    
    //MARK: internal
    
    func directoryFound(
        directory:DVitaItemDirectory,
        event:MVitaPtpMessageInEvent)
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
            event:event)
    }
}
