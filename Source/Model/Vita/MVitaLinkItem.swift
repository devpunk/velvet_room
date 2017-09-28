import Foundation

extension MVitaLink
{
    //MARK: internal
    
    func requestItemStatus(
        itemStatus:MVitaItemStatus,
        event:MVitaPtpMessageInEvent)
    {
        //TODO: validate with db
        //          result success if not found
        
        sendResultSuccess(event:event)
    }
}
