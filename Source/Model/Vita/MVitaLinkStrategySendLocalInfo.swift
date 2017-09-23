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
        model?.delegate?.linkError(message:message)
    }
    
    override func success()
    {
        print("success sent local info")
    }
    
    //MARK: private
    
    private func sendData()
    {
        guard
            
            let infoUrl:URL = Bundle.main.url(
                forResource:kResourceName,
                withExtension:kResourceExtension)
            
        else
        {
            failed()
            
            return
        }
        
        let data:Data
        
        do
        {
            try data = Data(
                contentsOf:infoUrl,
                options:Data.ReadingOptions.mappedIfSafe)
        }
        catch
        {
            failed()
            
            return
        }
        
        debugPrint(String.init(data:data, encoding:String.Encoding.utf8))
        
        send(
            data:data,
            code:MVitaPtpCommand.sendLocalInfo)
    }
}
