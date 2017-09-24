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
            
            self?.settings(xml:xml)
        }
    }
    
    //MARK: private
    
    private func settings(xml:[String:Any])
    {
        print("xml")
        print(xml)
        
//        guard
//
//            let vitaCapabilities:MVitaCapabilities = MVitaCapabilities.factoryCapabilities(
//                xml:xml)
//
//            else
//        {
//            failed()
//
//            return
//        }
//
//        model?.sendLocalCapabilities(
//            vitaCapabilities:vitaCapabilities)
    }
}
