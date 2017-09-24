import Foundation
import XmlHero

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
        model?.delegate?.vitaLinkError(message:message)
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
        
        send(
            data:data,
            code:MVitaPtpCommand.sendLocalInfo)
    }
}
