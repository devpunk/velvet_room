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
    
    func requestItemStatus(
        event:MVitaPtpMessageInEvent)
    {
        let message:MVitaPtpMessageOutEventCommand = MVitaPtpMessageOutEventCommand(
            event:event,
            dataPhase:MVitaPtpDataPhase.request,
            command:MVitaPtpCommand.requestItemStatus)
        writeMessageAndRead(message:message)
    }
    
    func requestItemTreat(
        event:MVitaPtpMessageInEvent)
    {
        let message:MVitaPtpMessageOutEventCommand = MVitaPtpMessageOutEventCommand(
            event:event,
            dataPhase:MVitaPtpDataPhase.request,
            command:MVitaPtpCommand.requestItemTreat)
        writeMessageAndRead(message:message)
    }
    
    func requestItemFormat(
        itemTreat:MVitaItemTreat)
    {
        let message:MVitaPtpMessageOutItemProperty = MVitaPtpMessageOutItemProperty(
            itemTreat:itemTreat,
            dataPhase:MVitaPtpDataPhase.request,
            property:MVitaPtpItemProperty.format)
        writeMessageAndRead(message:message)
    }
    
    func requestItemFileName(
        itemTreat:MVitaItemTreat)
    {
        let message:MVitaPtpMessageOutItemProperty = MVitaPtpMessageOutItemProperty(
            itemTreat:itemTreat,
            dataPhase:MVitaPtpDataPhase.request,
            property:MVitaPtpItemProperty.fileName)
        writeMessageAndRead(message:message)
    }
    
    func requestItemDateModified(
        itemTreat:MVitaItemTreat)
    {
        let message:MVitaPtpMessageOutItemProperty = MVitaPtpMessageOutItemProperty(
            itemTreat:itemTreat,
            dataPhase:MVitaPtpDataPhase.request,
            property:MVitaPtpItemProperty.dateModified)
        writeMessageAndRead(message:message)
    }
    
    func requestItemElements(
        itemTreat:MVitaItemTreat)
    {
        let message:MVitaPtpMessageOutItemProperty = MVitaPtpMessageOutItemProperty(
            itemTreat:itemTreat,
            dataPhase:MVitaPtpDataPhase.request,
            property:MVitaPtpItemProperty.dateModified)
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
