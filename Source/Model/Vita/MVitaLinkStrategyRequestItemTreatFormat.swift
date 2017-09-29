import Foundation

final class MVitaLinkStrategyRequestItemTreatFormat:MVitaLinkStrategyRequestItemTreatProtocol
{
    //MARK: internal
    
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
        
        print("format \(itemFormat.rawValue)")
        
        strategy.requestFileName(itemFormat:itemFormat)
    }
}
