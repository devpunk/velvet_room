import Foundation

final class MVitaLinkStrategyRequestItemTreatTest:MVitaLinkStrategyRequestItemTreatProtocol
{
    //MARK: internal
    
    func success(
        strategy:MVitaLinkStrategyRequestItemTreat)
    {
        print("data size: \(strategy.data.count)")
        
        strategy.requestItemContent()
        
        guard
        
            let array:[UInt8] = strategy.data.arrayFromBytes(
                elements:strategy.data.count)
        
        else
        {
            return
        }
        
        print("array")
        print(array)
    }
}
