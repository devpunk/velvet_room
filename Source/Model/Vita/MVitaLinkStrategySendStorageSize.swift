import Foundation
import XmlHero

final class MVitaLinkStrategySendStorageSize:
    MVitaLinkStrategySendData,
    MVitaLinkStrategyEventProtocol
{
    var event:MVitaPtpMessageInEvent?
    
    required init(model:MVitaLink)
    {
        super.init(model:model)
        sendData()
    }
    
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
    
    //MARK: private
    
    private func sendData()
    {
        let data:Data = factoryData()
        let message
    }
    
    private func factoryData() -> Data
    {
        
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
