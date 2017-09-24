import Foundation
import XmlHero

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
        model?.delegate?.linkError(message:message)
    }
    
    override func success()
    {
        
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
