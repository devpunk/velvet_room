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
    
    func sendLocalStatus(status:MVitaPtpLocalStatus)
    {
        let message:MVitaPtpMessageOutSendLocalStatus = MVitaPtpMessageOutSendLocalStatus(
            status:status)
        writeMessageAndRead(message:message)
    }
    
    func requestSettings(
        event:MVitaPtpMessageInEvent)
    {
        let message:MVitaPtpMessageOutRequestSettings = MVitaPtpMessageOutRequestSettings(
            event:event)
        writeMessageAndRead(message:message)
    }
    
    func sendResult(
        event:MVitaPtpMessageInEvent,
        result:MVitaPtpResult)
    {
        let message:MVitaPtpMessageOutSendResult = MVitaPtpMessageOutSendResult(
            event:event,
            result:result)
        writeMessageAndRead(message:message)
    }
}