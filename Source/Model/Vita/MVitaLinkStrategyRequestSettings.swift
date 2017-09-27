import Foundation
import XmlHero

final class MVitaLinkStrategyRequestSettings:MVitaLinkStrategyRequestDataEvent
{
    override func failed()
    {
        let message:String = String.localizedModel(
            key:"MVitaLinkStrategyRequestSettings_messageFailed")
        model?.delegate?.vitaLinkError(message:message)
    }
    
    override func success()
    {
        let unwrappedData:Data = MVitaLink.unwrapDataWithSizeHeader(
            data:data)
        
        Xml.object(data:unwrappedData)
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
        guard

            let vitaSettings:MVitaSettings = MVitaSettings.factorySettings(
                xml:xml),
            let event:MVitaPtpMessageInEvent = self.event

        else
        {
            failed()

            return
        }

        model?.sendResult(
            vitaSettings:vitaSettings,
            event:event)
    }
}
