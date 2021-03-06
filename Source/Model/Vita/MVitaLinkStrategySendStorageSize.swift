import Foundation

final class MVitaLinkStrategySendStorageSize:
    MVitaLinkStrategySendData,
    MVitaLinkStrategyEventProtocol
{
    private var event:MVitaPtpMessageInEvent?
    
    override func failed()
    {
        let message:String = String.localizedModel(
            key:"MVitaLinkStrategySendStorageSize_messageFailed")
        model?.errorCloseConnection(
            message:message)
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
        
        model?.sendResultSuccess(
            event:event,
            parameters:[])
    }
    
    //MARK: event protocol
    
    func config(event:MVitaPtpMessageInEvent)
    {
        self.event = event
        
        let data:Data = factoryData()
        let message:MVitaPtpMessageOutEventCommand = MVitaPtpMessageOutEventCommand(
            event:event,
            dataPhase:MVitaPtpDataPhase.send,
            command:MVitaPtpCommand.sendStorageSize)
        
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
