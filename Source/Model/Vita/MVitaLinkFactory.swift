import Foundation
import CocoaAsyncSocket

extension MVitaLink
{
    private static let kCommandQueueLabel:String = "velvetRoom.vitaLink.command"
    private static let kEventQueueLabel:String = "velvetRoom.vitaLink.event"
    
    //MARK: private
    
    private class func factoryCommandQueue() -> DispatchQueue
    {
        let queue = DispatchQueue(
            label:kCommandQueueLabel,
            qos:DispatchQoS.background,
            attributes:DispatchQueue.Attributes(),
            autoreleaseFrequency:DispatchQueue.AutoreleaseFrequency.inherit,
            target:DispatchQueue.global(qos:DispatchQoS.QoSClass.background))
        
        return queue
    }
    
    private class func factoryEventQueue() -> DispatchQueue
    {
        let queue = DispatchQueue(
            label:kEventQueueLabel,
            qos:DispatchQoS.background,
            attributes:DispatchQueue.Attributes(),
            autoreleaseFrequency:DispatchQueue.AutoreleaseFrequency.inherit,
            target:DispatchQueue.global(qos:DispatchQoS.QoSClass.background))
        
        return queue
    }
    
    //MARK: internal
    
    class func factoryLinkCommand() -> MVitaLinkCommand?
    {
        let delegate:MVitaLinkCommandDelegate = MVitaLinkCommandDelegate()
        let queue:DispatchQueue = factoryCommandQueue()
        
        guard
            
            let socket:GCDAsyncSocket = factoryTcpSocket(
                delegate:delegate,
                queue:queue)
            
        else
        {
            return nil
        }
        
        let linkCommand:MVitaLinkCommand = MVitaLinkCommand(
            socket:socket,
            delegate:delegate,
            queue:queue)
        delegate.model = linkCommand
        
        return linkCommand
    }
    
    class func factoryLinkEvent() -> MVitaLinkEvent?
    {
        let delegate:MVitaLinkEventDelegate = MVitaLinkEventDelegate()
        let queue:DispatchQueue = factoryEventQueue()
        
        guard
            
            let socket:GCDAsyncSocket = factoryTcpSocket(
                delegate:delegate,
                queue:queue)
            
        else
        {
            return nil
        }
        
        let linkEvent:MVitaLinkEvent = MVitaLinkEvent(
            socket:socket,
            delegate:delegate,
            queue:queue)
        delegate.model = linkEvent
        
        return linkEvent
    }
}
