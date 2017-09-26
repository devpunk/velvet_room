import Foundation
import XmlHero

final class MVitaLinkStrategyRequestSettings:
    MVitaLinkStrategyRequestData,
    MVitaLinkStrategyEventProtocol
{
    private var event:MVitaPtpMessageInEvent?
    
    override func failed()
    {
        let message:String = String.localizedModel(
            key:"MVitaLinkStrategyRequestSettings_messageFailed")
        model?.delegate?.vitaLinkError(message:message)
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
    
    //MARK: event protocol
    
    func config(event:MVitaPtpMessageInEvent)
    {
        self.event = event
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
