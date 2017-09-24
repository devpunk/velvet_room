import Foundation

extension MVitaLink
{
    //MARK: private
    
    private func unknownEventReceived()
    {
        let message:String = String.localizedModel(
            key:"MVitaLink_unknownEventReceived")
        delegate?.linkError(message:message)
    }
    
    //MARK: internal
    
    func receivedEvent(message:MVitaPtpMessageInEvent)
    {
        switch message.code
        {
        default:
            
            unknownEventReceived()
            
            break
        }
    }
}
