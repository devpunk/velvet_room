import Foundation

final class MVitaLinkSocketCommand:MVitaLinkSocket
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
        let message:MVitaPtpMessageOutGenericCommand = MVitaPtpMessageOutGenericCommand(
            dataPhase:MVitaPtpDataPhase.request,
            command:MVitaPtpCommand.requestVitaInfo)
        writeMessageAndRead(message:message)
    }
    
    func requestVitaCapabilities()
    {
        let message:MVitaPtpMessageOutGenericCommand = MVitaPtpMessageOutGenericCommand(
            dataPhase:MVitaPtpDataPhase.request,
            command:MVitaPtpCommand.requestVitaCapabilities)
        writeMessageAndRead(message:message)
    }
    
    func sendLocalStatus(status:MVitaPtpLocalStatus)
    {
        let message:MVitaPtpMessageOutSendLocalStatus = MVitaPtpMessageOutSendLocalStatus(
            status:status)
        writeMessageAndRead(message:message)
    }
    
    func closeSession()
    {
        let message:MVitaPtpMessageOutGenericCommand = MVitaPtpMessageOutGenericCommand(
            dataPhase:MVitaPtpDataPhase.none,
            command:MVitaPtpCommand.closeSession)
        writeMessageAndRead(message:message)
    }
}
