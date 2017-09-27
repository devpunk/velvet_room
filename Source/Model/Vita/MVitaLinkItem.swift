import Foundation

extension MVitaLink
{
    //MARK: internal
    
    func requestItemStatus(
        itemStatus:MVitaItemStatus,
        event:MVitaPtpMessageInEvent)
    {
        sendResultSuccess(event:event)
    }
}
