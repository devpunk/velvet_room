import Foundation

final class MVitaLinkStrategyRequestItemTreatDateCreated:MVitaLinkStrategyRequestItemTreatProtocol
{
    //MARK: internal
    
    func success(
        strategy:MVitaLinkStrategyRequestItemTreat)
    {
        guard
            
            let itemDateCreated:Date = MVitaPtpDate.factoryDate(
                data:strategy.data)
            
        else
        {
            strategy.failed()
            
            return
        }
        
        strategy.requestDateModified(
            itemDateCreated:itemDateCreated)
    }
}
