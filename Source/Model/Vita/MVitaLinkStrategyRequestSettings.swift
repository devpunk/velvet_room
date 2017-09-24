import Foundation
import XmlHero

final class MVitaLinkStrategyRequestSettings:MVitaLinkStrategyRequestData
{
    override func failed()
    {
        let message:String = String.localizedModel(
            key:"MVitaLinkStrategyRequestSettings_messageFailed")
        model?.delegate?.linkError(message:message)
    }
    
    override func success()
    {
        Xml.object(data:data)
        { [weak self] (xml:[String:Any]?, error:XmlError?) in
            
            guard
                
                let xml:[String:Any] = xml,
                error == nil
                
            else
            {
                self?.failed()
                
                return
            }
            
            self?.vitaSettings(xml:xml)
        }
    }
    
    //MARK: private
    
    private func vitaSettings(xml:[String:Any])
    {
        print("xml")
        print(xml)
        
        guard

            let vitaSettings:MVitaSettings = MVitaSettings.factorySettings(
                xml:xml)

        else
        {
            failed()

            return
        }

        model?.receivedSettings(
            vitaSettings:vitaSettings)
    }
}
