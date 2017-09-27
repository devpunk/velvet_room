import Foundation
import XmlHero

final class MVitaLinkStrategyRequestVitaCapabilities:MVitaLinkStrategyRequestData
{
    override func failed()
    {
        let message:String = String.localizedModel(
            key:"MVitaLinkStrategyRequestVitaCapabilities_messageFailed")
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
            
            self?.vitaCapabilities(xml:xml)
        }
    }
    
    //MARK: private
    
    private func vitaCapabilities(xml:[String:Any])
    {
        guard
            
            let vitaCapabilities:MVitaCapabilities = MVitaCapabilities.factoryCapabilities(
                xml:xml)
        
        else
        {
            failed()
            
            return
        }
        
        model?.sendLocalCapabilities(
            vitaCapabilities:vitaCapabilities)
    }
}
