import Foundation

extension MVitaLinkSocketCommand
{
    //MARK: internal
    
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
        guard
            
            let storageId:UInt32 = model?.configuration.storageId
        
        else
        {
            return
        }
        
        let message:MVitaPtpMessageOutItemElements = MVitaPtpMessageOutItemElements(
            itemTreat:itemTreat,
            storageId:storageId)
        writeMessageAndRead(message:message)
    }
    
    func requestItemFileSize(
        itemTreat:MVitaItemTreat)
    {
        let message:MVitaPtpMessageOutItemProperty = MVitaPtpMessageOutItemProperty(
            itemTreat:itemTreat,
            dataPhase:MVitaPtpDataPhase.request,
            property:MVitaPtpItemProperty.fileSize)
        writeMessageAndRead(message:message)
    }
    
    func requestItemData(
        itemTreat:MVitaItemTreat)
    {
        let message:MVitaPtpMessageOutItemData = MVitaPtpMessageOutItemData(
            itemTreat:itemTreat,
            dataPhase:MVitaPtpDataPhase.request)
        writeMessageAndRead(message:message)
    }
}
