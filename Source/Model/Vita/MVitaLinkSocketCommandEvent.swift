import Foundation

extension MVitaLinkSocketCommand
{
    //MARK: internal
    
    func requestSettings(
        event:MVitaPtpMessageInEvent)
    {
        let message:MVitaPtpMessageOutEventCommand = MVitaPtpMessageOutEventCommand(
            event:event,
            dataPhase:MVitaPtpDataPhase.request,
            command:MVitaPtpCommand.requestSettings)
        writeMessageAndRead(message:message)
    }
    
    func sendResult(
        event:MVitaPtpMessageInEvent,
        result:MVitaPtpResult,
        parameters:[UInt32])
    {
        let message:MVitaPtpMessageOutSendResult = MVitaPtpMessageOutSendResult(
            event:event,
            result:result,
            parameters:parameters)
        writeMessageAndRead(message:message)
    }
}
