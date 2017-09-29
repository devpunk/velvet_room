import Foundation

final class MVitaLinkStrategyRequestItemTreatElements:MVitaLinkStrategyRequestItemTreatProtocol
{
    func success(
        strategy:MVitaLinkStrategyRequestItemTreat)
    {
        let data:Data = strategy.data
        let counterSize:Int = MemoryLayout<UInt32>.size
        
        guard
        
            let rawCountElements:UInt32 = data.valueFromBytes()
        
        else
        {
            strategy.failed()
            
            return
        }
        
        let countElements:Int = Int(rawCountElements)
        let subData:Data = data.subdata(
            start:counterSize)
        
        guard
        
            let elements:[UInt32] = subData.arrayFromBytes(
                elements:countElements)
        
        else
        {
            strategy.failed()
            
            return
        }
    }
}
