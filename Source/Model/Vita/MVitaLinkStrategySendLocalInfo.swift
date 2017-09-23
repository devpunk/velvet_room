import Foundation
import XmlHero

final class MVitaLinkStrategySendLocalInfo:MVitaLinkStrategySendData
{
    private let kResourceName:String = "vitaLocalInfo"
    private let kResourceExtension:String = "xml"
    
    required init(model:MVitaLink)
    {
        super.init(model:model)
        
        guard
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
}
