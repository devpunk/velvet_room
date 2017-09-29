import Foundation

final class MVitaLinkStrategyRequestItemTreatName:MVitaLinkStrategyRequestItemTreatProtocol
{
    //MARK: internal
    
    func success(
        strategy:MVitaLinkStrategyRequestItemTreat)
    {
        guard
            
            let itemFileName:String = MVitaPtpString.factoryString(
                data:strategy.data)
            
        else
        {
            strategy.failed()
            
            return
        }
        
        strategy.requestDateModified(
            itemFileName:itemFileName)
    }
}
