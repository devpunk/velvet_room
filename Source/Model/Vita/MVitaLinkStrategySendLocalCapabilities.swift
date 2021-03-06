import Foundation

final class MVitaLinkStrategySendLocalCapabilities:MVitaLinkStrategySendData
{
    private let kResourceName:String = "vitaLocalCapabilities"
    private let kResourceExtension:String = "xml"
    
    required init(model:MVitaLink)
    {
        super.init(model:model)
        sendData()
    }
    
    override func failed()
    {
        let message:String = String.localizedModel(
            key:"MVitaLinkStrategySendLocalCapabilities_messageFailed")
        model?.errorCloseConnection(
            message:message)
    }
    
    override func success()
    {
        model?.connectionReady()
    }
    
    //MARK: private
    
    private func sendData()
    {
        guard
            
            let data:Data = MVitaLink.loadData(
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
            command:MVitaPtpCommand.sendLocalCapabilities)
        
        send(
            data:wrappedData,
            message:message)
    }
}
