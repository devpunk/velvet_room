import Foundation

extension MVitaLinkStrategySendItem
{
    //MARK: private
    
    private func sendElementInfo(
        element:DVitaItemElement,
        handles:MVitaPtpMessageInEventHandles)
    {
        guard

            let configuration:MVitaConfiguration = model?.configuration,
            let elementPacked:MVitaPtpPackElement = MVitaPtpPackElement(
                element:element,
                configuration:configuration,
                parentHandle:handles.parent)

        else
        {
            failed()

            return
        }

        let message:MVitaPtpMessageOutSendItemInfo = MVitaPtpMessageOutSendItemInfo(
            storageId:configuration.storage.storageId,
            parentHandle:handles.parent)

        send(
            data:elementPacked.data,
            message:message)
    }
    
    private func sendElementData(
        element:DVitaItemElement)
    {
        guard
            
            let data:Data = MVitaLink.elementData(
                element:element)
        
        else
        {
            failed()
            
            return
        }
        
        let message:MVitaPtpMessageOutSendItem = MVitaPtpMessageOutSendItem()
        
        send(
            data:data,
            message:message)
    }
    
    //MARK: internal
    
    func lastElementInfo()
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
        
            let element:DVitaItemElement = self.elements?.last
        
        else
        {
            sentAllItems()
            
            return
        }
        
        changeStatus(
            statusType:MVitaLinkStrategySendItemElementInfo.self)
        sendElementInfo(
            element:element,
            handles:handles)
    }
    
    func lastElementDataAndPop()
    {
        guard
            
            let element:DVitaItemElement = self.elements?.popLast()
            
        else
        {
            failed()
            
            return
        }
        
        changeStatus(
            statusType:MVitaLinkStrategySendItemElementData.self)
        sendElementData(element:element)
    }
}
