import Foundation

extension MVitaLinkStrategySendItem
{
    private func sendDirectory(
        directory:DVitaItemDirectory,
        event:MVitaPtpMessageInEvent)
    {
        
    }
    
    //MARK: internal
    
    func directoryReceived(
        directory:DVitaItemDirectory,
        event:MVitaPtpMessageInEvent)
    {
        self.elements = directory.elements?.array as? [DVitaItemElement]
        
        
    }
}
