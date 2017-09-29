import Foundation

final class MVitaLinkStrategyRequestItemTreatSize:MVitaLinkStrategyRequestItemTreatProtocol
{
    //MARK: internal
    
    func success(
        strategy:MVitaLinkStrategyRequestItemTreat)
    {
        guard
        
            let itemSize:UInt32 = strategy.data.valueFromBytes()
        
        else
        {
            strategy.failed()
            
            return
        }
        
        print("item size: \(itemSize)")
    }
}
