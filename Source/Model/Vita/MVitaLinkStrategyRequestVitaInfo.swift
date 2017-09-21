import Foundation
import XmlHero

final class MVitaLinkStrategyRequestVitaInfo:MVitaLinkStrategyReceiveData
{
    override func failed()
    {
        let message:String = String.localizedModel(
            key:"MVitaLinkStrategyRequestVitaInfo_messageFailed")
        model?.delegate?.linkError(message:message)
    }
    
    override func success()
    {
        Xml.object(data:data)
        { [weak self] (xml:Any?, error:XmlError?) in
            
            guard
            
                let xml:Any = xml,
                error == nil
            
            else
            {
                self?.failed()
                
                return
            }
            
            self?.vitaInfo(xml:xml)
        }
    }
    
    //MARK: private
    
    private func vitaInfo(xml:Any)
    {
        
    }
}
