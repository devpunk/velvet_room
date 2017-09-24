import Foundation
import CocoaAsyncSocket

extension MVitaLink
{
    private static let kCommandQueueLabel:String = "velvetRoom.vitaLink.socketCommand"
    private static let kEventQueueLabel:String = "velvetRoom.vitaLink.socketEvent"
    
    //MARK: private
    
    private class func factoryCommandQueue() -> DispatchQueue
    {
        let queue = DispatchQueue(
            label:kCommandQueueLabel,
            qos:DispatchQoS.background,
            attributes:DispatchQueue.Attributes(),
            autoreleaseFrequency:
            DispatchQueue.AutoreleaseFrequency.inherit,
            target:DispatchQueue.global(
                qos:DispatchQoS.QoSClass.background))
        
        return queue
    }
    
    private class func factoryEventQueue() -> DispatchQueue
    {
        let queue = DispatchQueue(
            label:kEventQueueLabel,
            qos:DispatchQoS.background,
            attributes:DispatchQueue.Attributes(),
            autoreleaseFrequency:
            DispatchQueue.AutoreleaseFrequency.inherit,
            target:DispatchQueue.global(
                qos:DispatchQoS.QoSClass.background))
        
        return queue
    }
    
    //MARK: internal
    
    class func factorySocketCommand() -> MVitaLinkSocketCommand
    {
        let delegate:MVitaLinkSocketCommandDelegate = MVitaLinkSocketCommandDelegate()
        let queue:DispatchQueue = factoryCommandQueue()
        let socket:GCDAsyncSocket = GCDAsyncSocket(
            delegate:delegate,
            delegateQueue:queue,
            socketQueue:queue)
        
        let linkCommand:MVitaLinkSocketCommand = MVitaLinkSocketCommand(
            socket:socket,
            delegate:delegate,
            queue:queue)
        delegate.model = linkCommand
        
        return linkCommand
    }
    
    class func factorySocketEvent() -> MVitaLinkSocketEvent
    {
        let delegate:MVitaLinkSocketEventDelegate = MVitaLinkSocketEventDelegate()
        let queue:DispatchQueue = factoryEventQueue()
        let socket:GCDAsyncSocket = GCDAsyncSocket(
            delegate:delegate,
            delegateQueue:queue,
            socketQueue:queue)
        
        let linkEvent:MVitaLinkSocketEvent = MVitaLinkSocketEvent(
            socket:socket,
            delegate:delegate,
            queue:queue)
        delegate.model = linkEvent
        
        return linkEvent
    }
    
    class func factoryStrategyStatus(
        status:MVitaPtpLocalStatus) -> MVitaLinkStrategySendLocalStatus.Type
    {
        switch status
        {
        case MVitaPtpLocalStatus.connection:
            
            return MVitaLinkStrategySendLocalStatusConnection.self
            
        case MVitaPtpLocalStatus.connectionEnd:
            
            return MVitaLinkStrategySendLocalStatusConnectionEnd.self
            
        default:
            
            return MVitaLinkStrategySendLocalStatus.self
        }
    }
}
