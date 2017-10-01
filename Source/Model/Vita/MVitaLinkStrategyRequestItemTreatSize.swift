import Foundation

final class MVitaLinkStrategyRequestItemTreatSize:MVitaLinkStrategyRequestItemTreatProtocol
{
    //MARK: internal
    
    func success(
        strategy:MVitaLinkStrategyRequestItemTreat)
    {
        guard
        
            let itemSize:UInt64 = strategy.data.valueFromBytes()
        
        else
        {
            strategy.failed()
            
            return
        }
        
        strategy.requestItemTest(itemSize:itemSize)
    }
}
