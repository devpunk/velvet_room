import Foundation
import CocoaAsyncSocket

extension MConnectingSocket
{
    private static let kUdpQueueLabel:String = "velvetRoom.connecting.udp"
    private static let kTcpQueueLabel:String = "velvetRoom.connecting.tcp"
    
    //MARK: private
    
    private class func factoryUdpQueue() -> DispatchQueue
    {
        let queue = DispatchQueue(
            label:kUdpQueueLabel,
            qos:DispatchQoS.background,
            attributes:DispatchQueue.Attributes(),
            autoreleaseFrequency:DispatchQueue.AutoreleaseFrequency.inherit,
            target:DispatchQueue.global(qos:DispatchQoS.QoSClass.background))
        
        return queue
    }
    
    private class func factoryTcpQueue() -> DispatchQueue
    {
        let queue = DispatchQueue(
            label:kTcpQueueLabel,
            qos:DispatchQoS.background,
            attributes:DispatchQueue.Attributes(),
            autoreleaseFrequency:DispatchQueue.AutoreleaseFrequency.inherit,
            target:DispatchQueue.global(qos:DispatchQoS.QoSClass.background))
        
        return queue
    }
}
