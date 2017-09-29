import Foundation

final class MVitaLinkStrategyRequestItemTreatDateModified:MVitaLinkStrategyRequestItemTreatProtocol
{
    //MARK: internal
    
    func success(
        strategy:MVitaLinkStrategyRequestItemTreat)
    {
        guard
            
            let itemDateModified:Date = MVitaPtpDate.factoryDate(
                data:strategy.data)
        
        else
        {
            strategy.failed()
            
            return
        }
        
        strategy.requestItemElements(
            itemDateModified:itemDateModified)
    }
}
