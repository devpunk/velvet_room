import Foundation

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
        if let receivingString:String = String(
            data:data,
            encoding:String.Encoding.utf8)
        {
            print("data in xml:")
            print(receivingString)
        }
        else
        {
            print("can't create string")
        }
    }
}
