import Foundation

final class MVitaLinkStrategyRequestItemTreatStart:MVitaLinkStrategyRequestItemTreatProtocol
{
    //MARK: internal
    
    func success(
        strategy:MVitaLinkStrategyRequestItemTreat)
    {
        guard
            
            let itemTreat:MVitaItemTreat = MVitaItemTreat.factoryTreat(
                data:strategy.data)
            
        else
        {
            strategy.failed()
            
            return
        }
        
        strategy.requestItemFormat(itemTreat:itemTreat)
    }
}
