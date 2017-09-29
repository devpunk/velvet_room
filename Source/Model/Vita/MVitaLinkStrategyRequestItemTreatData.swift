import Foundation

final class MVitaLinkStrategyRequestItemTreatData:MVitaLinkStrategyRequestItemTreatProtocol
{
    //MARK: internal
    
    func success(
        strategy:MVitaLinkStrategyRequestItemTreat)
    {
        print("item data size: \(strategy.data.count)")
        
        strategy.itemDataReceived(itemData:strategy.data)
    }
}
