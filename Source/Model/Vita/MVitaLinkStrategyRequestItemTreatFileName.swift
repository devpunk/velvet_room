import Foundation

final class MVitaLinkStrategyRequestItemTreatFileName:MVitaLinkStrategyRequestItemTreatProtocol
{
    func success(
        strategy:MVitaLinkStrategyRequestItemTreat)
    {
        print("filename length:\(strategy.data.count)")
        
        guard
        
            let fileName:String = String(
                data:strategy.data,
                encoding:String.Encoding.ascii)
        
        else
        {
            strategy.failed()
            
            return
        }
        
        print("file name: \(fileName)")
    }
}
