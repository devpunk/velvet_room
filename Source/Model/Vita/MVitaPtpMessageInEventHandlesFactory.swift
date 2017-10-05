import Foundation

extension MVitaPtpMessageInEventHandles
{
    private static let kTotalHandles:Int = 2
    
    //MARK: internal
    
    static func factoryHandles(
        event:MVitaPtpMessageInEvent) -> MVitaPtpMessageInEventHandles?
    {
        guard
        
            event.parameters.count == kTotalHandles,
            let item:UInt32 = event.parameters.first,
            let parent:UInt32 = event.parameters.last
        
        else
        {
            return nil
        }
        
        let handles:MVitaPtpMessageInEventHandles = MVitaPtpMessageInEventHandles(
            item:item,
            parent:parent)
        
        return handles
    }
}
