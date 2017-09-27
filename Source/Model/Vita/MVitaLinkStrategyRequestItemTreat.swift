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
        
        //trate size:12 array:Optional([14, 1, 67108869])
//        treat size:12 array:Optional([14, 1, 67108880])
//        treat size:12 array:Optional([14, 1, 67108874])
        
        print("treat size:\(data.count) array:\(array)")
    }
    
    //MARK: private

}
