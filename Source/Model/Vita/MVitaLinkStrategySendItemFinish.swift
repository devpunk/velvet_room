import Foundation

extension MVitaLinkStrategySendItem
{
    //MARK: internal
    
    func sentAllItems()
    {
        print("send completed")
        
        guard
            
            let event:MVitaPtpMessageInEvent = self.event,
            let handles:MVitaPtpMessageInEventHandles = self.handles
            
        else
        {
            failed()
            
            return
        }
        
        let parameters:[UInt32] = [
            handles.item]
        
        changeStatus(
            statusType:MVitaLinkStrategySendItemConfirm.self)
        model?.linkCommand.sendResult(
            event:event,
            result:MVitaPtpResult.success,
            parameters:parameters)
    }
    
    func sendInvalid()
    {
        guard
            
            let event:MVitaPtpMessageInEvent = self.event
            
        else
        {
            failed()
            
            return
        }
        
        changeStatus(
            statusType:MVitaLinkStrategySendItemInvalid.self)
        model?.linkCommand.sendResult(
            event:event,
            result:MVitaPtpResult.invalidData,
            parameters:[])
    }
}
