import Foundation

extension MVitaLinkStrategySendItem
{
    //MARK: private
    
    private func sendElement(
        element:DVitaItemElement,
        handles:MVitaPtpMessageInEventHandles)
    {
        guard

            let configuration:MVitaConfiguration = model?.configuration,
            let directoryPacked:MVitaPtpPackDirectory = MVitaPtpPackDirectory(
                directory:directory,
                configuration:configuration,
                parentHandle:handles.parent)

            else
        {
            failed()

            return
        }

        let message:MVitaPtpMessageOutSendItem = MVitaPtpMessageOutSendItem(
            storageId:configuration.storageId,
            parentHandle:handles.parent)

        send(
            data:directoryPacked.data,
            message:message)
    }
    
    //MARK: internal
    
    func sendNextElement()
    {
        guard
        
            self.elements != nil,
            let handles:MVitaPtpMessageInEventHandles = self.handles
        
        else
        {
            failed()
            
            return
        }
        
        guard
        
            let element:DVitaItemElement = self.elements?.popLast()
        
        else
        {
            sendCompleted()
            
            return
        }
        
        sendElement(
            element:element,
            handles:handles)
    }
}
