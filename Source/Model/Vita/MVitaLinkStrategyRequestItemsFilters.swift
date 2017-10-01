import Foundation

final class MVitaLinkStrategyRequestItemsFilters:MVitaLinkStrategyRequestDataEvent
{
    private let kTotalFilters:Int = 5
    private let kIndexCategory:Int = 0
    private let kIndexCount:Int = 3
    
    override func failed()
    {
        let message:String = String.localizedModel(
            key:"MVitaLinkStrategyRequestItemsFilters_messageFailed")
        model?.errorCloseConnection(
            message:message)
    }
    
    override func success()
    {
        guard
            
            let filters:[UInt32] = data.arrayFromBytes(
                elements:kTotalFilters)
        
        else
        {
            failed()
            
            return
        }
        
        let rawCategory:UInt32 = filters[kIndexCategory]
        let rawCount:UInt32 = filters[kIndexCount]
        
    }
}
