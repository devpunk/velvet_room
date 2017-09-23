import Foundation

final class MVitaLinkCommand:MVitaLinkSocket
{
    //MARK: internal
    
    func request()
    {
        let message:MVitaPtpMessageOutRequestCommand = MVitaPtpMessageOutRequestCommand()
        writeMessageAndRead(message:message)
    }
    
    func openSession()
    {
        let message:MVitaPtpMessageOutOpenSession = MVitaPtpMessageOutOpenSession()
        writeMessageAndRead(message:message)
    }
    
    func requestVitaInfo()
    {
        let message:MVitaPtpMessageOutRequestData = MVitaPtpMessageOutRequestData(
            code:MVitaPtpCommand.requestVitaInfo)
        writeMessageAndRead(message:message)
    }
    
    func requestVitaCapabilities()
    {
        let message:MVitaPtpMessageOutRequestData = MVitaPtpMessageOutRequestData(
            code:MVitaPtpCommand.requestVitaCapabilities)
        writeMessageAndRead(message:message)
    }
}
