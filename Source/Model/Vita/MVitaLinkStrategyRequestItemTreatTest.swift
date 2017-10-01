import Foundation

final class MVitaLinkStrategyRequestItemTreatTest:MVitaLinkStrategyRequestItemTreatProtocol
{
    //MARK: internal
    
    func success(
        strategy:MVitaLinkStrategyRequestItemTreat)
    {
        print("data size: \(strategy.data.count)")
        
        guard
        
            let array:[UInt8] = strategy.data.arrayFromBytes(
                elements:strategy.data.count)
        
        else
        {
            return
            strategy.requestItemContent()
        }
        
        print("array")
        print(array)
        
        
        guard
            
            let itemFileName:String = MVitaPtpString.factoryString(
                data:strategy.data)
        
        else
        {
            print("no string")
            strategy.requestItemContent()
            
            return
        }
        
        print("string")
        print(itemFileName)
        
        strategy.requestItemContent()
    }
}
