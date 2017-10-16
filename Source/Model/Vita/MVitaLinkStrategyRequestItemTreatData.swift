import Foundation

final class MVitaLinkStrategyRequestItemTreatData:MVitaLinkStrategyRequestItemTreatProtocol
{
    //MARK: internal
    
    func success(
        strategy:MVitaLinkStrategyRequestItemTreat)
    {
        strategy.itemDataReceived(itemData:strategy.data)
    }
}
