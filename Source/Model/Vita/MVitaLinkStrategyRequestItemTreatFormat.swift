import Foundation

final class MVitaLinkStrategyRequestItemTreatFormat:MVitaLinkStrategyRequestItemTreatProtocol
{
    func success(
        strategy:MVitaLinkStrategyRequestItemTreat)
    {
        let format:UInt16? = strategy.data.valueFromBytes()
        
        print("format data size: \(strategy.data.count) value:\(format)")
    }
}