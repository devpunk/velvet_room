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
    
    func requestItemsFilters(
        event:MVitaPtpMessageInEvent)
    {
        let message:MVitaPtpMessageOutEventCommand = MVitaPtpMessageOutEventCommand(
            event:event,
            dataPhase:MVitaPtpDataPhase.request,
            command:MVitaPtpCommand.requestItemsFilters)
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
        treatId:UInt32)
    {
        let message:MVitaPtpMessageOutRequestItemProperty = MVitaPtpMessageOutRequestItemProperty(
            treatId:treatId,
            property:MVitaPtpItemProperty.format)
        writeMessageAndRead(message:message)
    }
    
    func requestItemFileName(
        treatId:UInt32)
    {
        let message:MVitaPtpMessageOutRequestItemProperty = MVitaPtpMessageOutRequestItemProperty(
            treatId:treatId,
            property:MVitaPtpItemProperty.fileName)
        writeMessageAndRead(message:message)
    }
    
    func requestItemDateCreated(
        treatId:UInt32)
    {
        let message:MVitaPtpMessageOutRequestItemProperty = MVitaPtpMessageOutRequestItemProperty(
            treatId:treatId,
            property:MVitaPtpItemProperty.dateCreated)
        writeMessageAndRead(message:message)
    }
    
    func requestItemDateModified(
        treatId:UInt32)
    {
        let message:MVitaPtpMessageOutRequestItemProperty = MVitaPtpMessageOutRequestItemProperty(
            treatId:treatId,
            property:MVitaPtpItemProperty.dateModified)
        writeMessageAndRead(message:message)
    }
    
    func requestItemElements(
        treatId:UInt32)
    {
        guard
            
            let storageId:UInt32 = model?.configuration.storageId
        
        else
        {
            return
        }
        
        let message:MVitaPtpMessageOutRequestItemElements = MVitaPtpMessageOutRequestItemElements(
            treatId:treatId,
            storageId:storageId)
        writeMessageAndRead(message:message)
    }
    
    func requestItemFileSize(
        treatId:UInt32)
    {
        let message:MVitaPtpMessageOutRequestItemProperty = MVitaPtpMessageOutRequestItemProperty(
            treatId:treatId,
            property:MVitaPtpItemProperty.fileSize)
        writeMessageAndRead(message:message)
    }
    
    func requestItemData(
        treatId:UInt32)
    {
        let message:MVitaPtpMessageOutRequestItem = MVitaPtpMessageOutRequestItem(
            treatId:treatId)
        writeMessageAndRead(message:message)
    }
}
