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
        
//        send(data: <#T##Data#>, message: <#T##MVitaPtpMessageOutProtocol#>)
    }
    
    //MARK: internal
    
    func directoryReceived(
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
