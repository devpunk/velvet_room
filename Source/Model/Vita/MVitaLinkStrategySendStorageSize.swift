import Foundation
import XmlHero

final class MVitaLinkStrategySendStorageSize:
    MVitaLinkStrategySendData,
    MVitaLinkStrategyEventProtocol
{
    override func failed()
    {
        let message:String = String.localizedModel(
            key:"MVitaLinkStrategySendStorageSize_messageFailed")
        model?.delegate?.vitaLinkError(message:message)
    }
    
    override func success()
    {
        print("storage sent")
    }
    
    //MARK: event protocol
    
    func config(event:MVitaPtpMessageInEvent)
    {
        let data:Data = factoryData()
        let code:MVitaPtpCommand = MVitaPtpCommand.sendStorageSize
        let message:MVitaPtpMessageOutSendEventData = MVitaPtpMessageOutSendEventData(
            event:event,
            code:code)
        
        send(
            data:data,
            message:message)
    }
    
    //MARK: private
    
    private func factoryData() -> Data
    {
        let storageSize:UInt64 = factoryStorageSize()
        let availableStorage:UInt64 = factoryAvailableStorage()
        
        var data:Data = Data()
        data.append(value:storageSize)
        data.append(value:availableStorage)
        
        return data
    }
    
    private func factoryStorageSize() -> UInt64
    {
        guard
        
            let size:UInt64 = model?.configuration.local.storageSize
        
        else
        {
            return 0
        }
        
        return size
    }
    
    private func factoryAvailableStorage() -> UInt64
    {
        guard
        
            let available:UInt64 = model?.configuration.local.availableStorage,
            available >= FileManager.default.systemFreeSize
        
        else
        {
            return 0
        }
        
        return available
    }
}
