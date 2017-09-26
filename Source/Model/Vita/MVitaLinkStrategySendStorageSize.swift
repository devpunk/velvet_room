import Foundation
import XmlHero

final class MVitaLinkStrategySendStorageSize:MVitaLinkStrategySendData
{
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
        
//        send(
//            data:data,
//            code:MVitaPtpCommand.sendLocalInfo)
    }
}
