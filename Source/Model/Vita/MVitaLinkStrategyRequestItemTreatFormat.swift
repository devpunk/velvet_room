import Foundation

final class MVitaLinkStrategyRequestItemTreatFormat:MVitaLinkStrategyRequestItemTreatProtocol
{
    func success(
        strategy:MVitaLinkStrategyRequestItemTreat)
    {
        guard
        
            let itemFormat:MVitaItemFormat = MVitaItemFormat.factoryFormat(
                data:strategy.data)
        
        else
        {
            strategy.failed()
            
            return
        }
        
        strategy.requestFileName(itemFormat:itemFormat)
    }
}
