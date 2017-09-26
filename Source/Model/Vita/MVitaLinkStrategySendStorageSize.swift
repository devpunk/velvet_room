import Foundation
import XmlHero

final class MVitaLinkStrategySendStorageSize:
    MVitaLinkStrategySendData,
    MVitaLinkStrategyEventProtocol
{
    private var event:MVitaPtpMessageInEvent?
    
    override func failed()
    {
        let message:String = String.localizedModel(
            key:"MVitaLinkStrategySendStorageSize_messageFailed")
        model?.delegate?.vitaLinkError(message:message)
    }
    
    override func success()
    {
        guard
            
            let event:MVitaPtpMessageInEvent = self.event
            
        else
        {
            failed()
            
            return
        }
        
        model?.sendResultSuccess(event:event)
    }
    
    //MARK: event protocol
    
    func config(event:MVitaPtpMessageInEvent)
    {
        self.event = event
        
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
        
        print("st: \(storageSize) \(availableStorage)")
        
        let storage:UInt64 = 100
        let storage2:UInt64 = 1
        let empty:UInt8 = 0
        let empty2:UInt8 = 255
        
        var data:Data = Data()
        data.append(value:storage)
        data.append(value:storage2)
        data.append(value:empty)
        data.append(value:empty)
        data.append(value:empty)
        data.append(value:empty)
        data.append(value:empty)
        data.append(value:empty)
        data.append(value:empty)
        data.append(value:empty)
        data.append(value:empty2)
        data.append(value:empty)
//        data.append(value:availableStorage)
//        data.append(value:empty)
//        data.append(value:empty)
//        data.append(value:empty)
//        data.append(value:empty)
//        data.append(value:full)
//        data.append(value:full)
//        data.append(value:full)
//        data.append(value:full)
//        data.append(value:full)
        
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
        let realAvailableStorage:UInt64 = FileManager.default.systemFreeSize
        
        guard
        
            let available:UInt64 = model?.configuration.local.availableStorage,
            realAvailableStorage >= available
        
        else
        {
            return 0
        }
        
        return available
    }
}
