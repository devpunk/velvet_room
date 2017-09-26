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
        let message:MVitaPtpMessageOutSendEventData = MVitaPtpMessageOutSendEventData(
            event:event)
    }
    
    //MARK: private
    
    private func factoryData() -> Data
    {
        return Data()
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
