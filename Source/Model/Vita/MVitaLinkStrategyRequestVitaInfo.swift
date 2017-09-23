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
        /*
 
         <VITAInformation responderVersion="3.65" protocolVersion="01800010" comVersion="190" modelInfo="PCH02006ZA11" timezone="10"><photoThumb type="0" codecType="17" width="213" height="120"/><videoThumb type="1" codecType="5" width="213" height="120" duration="15"/><musicThumb type="0" codecType="17" width="192" height="192"/><gameThumb type="0" codecType="17" width="192" height="192"/></VITAInformation>
         
 */
        
        Xml.object(data:data)
        { [weak self] (xml:Any?, error:XmlError?) in
            
            if let error:XmlError = error
            {
                print("error")
                print(error.localizedDescription)
                
                return
            }
            
            guard
            
                let xml:Any = xml,
                error == nil
            
            else
            {
                print("error \(error?.localizedDescription)")
                self?.failed()
                
                return
            }
            
            self?.vitaInfo(xml:xml)
        }
    }
    
    //MARK: private
    
    private func vitaInfo(xml:Any)
    {
        print(xml)
    }
}
