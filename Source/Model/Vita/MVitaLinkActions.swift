import Foundation

extension MVitaLink
{
    //MARK: internal
    
    func cancel()
    {
        linkCommand.cancel()
        linkEvent.cancel()
    }
    
    func disconnected()
    {
        let message:String = String.localizedModel(
            key:"MVitaLink_errorDisconnected")
        delegate?.linkError(message:message)
    }
}
