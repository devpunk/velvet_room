import Foundation

final class MVitaLinkStrategySendLocalInfo:MVitaLinkStrategySendData
{
    private let kResourceName:String = "vitaLocalInfo"
    private let kResourceExtension:String = "xml"
    
    required init(model:MVitaLink)
    {
        super.init(model:model)
        sendData()
    }
    
    override func failed()
    {
        let message:String = String.localizedModel(
            key:"MVitaLinkStrategySendLocalInfo_messageFailed")
        model?.closeConnectionDueToError(
            message:message)
    }
    
    override func success()
    {
        model?.requestVitaCapabilities()
    }
    
    //MARK: private
    
    private func sendData()
    {
        guard
            
            let data:Data = loadData(
                resourceName:kResourceName,
                resourceExtension:kResourceExtension)
            
        else
        {
            failed()
            
            return
        }
        
        let wrappedData:Data = MVitaLink.wrapDataWithSizeHeader(
            data:data)
        let message:MVitaPtpMessageOutGenericCommand = MVitaPtpMessageOutGenericCommand(
            dataPhase:MVitaPtpDataPhase.send,
            command:MVitaPtpCommand.sendLocalInfo)
        
        send(
            data:wrappedData,
            message:message)
    }
}
