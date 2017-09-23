import Foundation
import XmlHero

final class MVitaLinkStrategyRequestVitaInfo:MVitaLinkStrategyRequestData
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
        { [weak self] (xml:[String:Any]?, error:XmlError?) in
            
            if let error:XmlError = error
            {
                print("error")
                print(error.localizedDescription)
                
                return
            }
            
            guard
            
                let xml:[String:Any] = xml,
                error == nil
            
            else
            {
                self?.failed()
                
                return
            }
            
            print("xml")
            print(xml)
            
            self?.vitaInfo(xml:xml)
        }
    }
    
    //MARK: private
    
    private func vitaInfo(xml:[String:Any])
    {
        guard
        
            let vitaInfo:MVitaInfo = MVitaInfo.factoryInfo(
                xml:xml)
        
        else
        {
            failed()
            
            return
        }
        
        model?.sendLocalInfo(vitaInfo:vitaInfo)
    }
}
