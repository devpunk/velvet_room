import Foundation

final class MVitaLinkCommand:MVitaLinkSocket
{
    //MARK: internal
    
    func request()
    {
        let message:MVitaPtpMessageOutRequestCommand = MVitaPtpMessageOutRequestCommand()
        writeMessage(message:message)
    }
    
    func openSession()
    {
        let message:MVitaPtpMessageOutRequestCommand = MVitaPtpMessageOutRequestCommand()
        writeMessage(message:message)
    }
}
