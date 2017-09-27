import Foundation

final class MVitaLinkStrategyRequestItemTreat:MVitaLinkStrategyRequestDataEvent
{
    override func failed()
    {
        let message:String = String.localizedModel(
            key:"MVitaLinkStrategyRequestItemTreat_messageFailed")
        model?.delegate?.vitaLinkError(message:message)
    }
    
    override func success()
    {
        let array:[UInt32]? = data.arrayFromBytes(elements:3)
        
        print("trate size:\(data.count) array:\(array)")
    }
    
    //MARK: private

}
