import Foundation

final class MVitaLinkStrategyRequestItemTreatDateModified:MVitaLinkStrategyRequestItemTreatProtocol
{
    func success(
        strategy:MVitaLinkStrategyRequestItemTreat)
    {
        print("data length \(strategy.data.count)")
        
        guard
            
            let itemFileName:String = MVitaPtpString.factoryString(
                data:strategy.data)
            
        else
        {
            strategy.failed()
            
            return
        }
        
        print("date: \(itemFileName)")
    }
}
