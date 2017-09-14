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
    
    private class func factoryUdpSocket(
        configuration:MVitaConfiguration,
        queue:DispatchQueue) -> GCDAsyncUdpSocket?
    {
        let socket:GCDAsyncUdpSocket = GCDAsyncUdpSocket(
            socketQueue:queue)
        
        socket.setPreferIPv4()
        socket.setIPv6Enabled(false)
        
        do
        {
            try socket.bind(
                toPort:configuration.port)
        }
        catch
        {
            return nil
        }
        
        do
        {
            try socket.enableReusePort(true)
        }
        catch
        {
            return nil
        }
        
        do
        {
            try socket.beginReceiving()
        }
        catch
        {
            return nil
        }
        
        return socket
    }
    
    //MARK: internal
    
    class func factoryUdp(
        configuration:MVitaConfiguration) -> MConnectingSocketUdp?
    {
        let queue:DispatchQueue = factoryUdpQueue()
        
        guard
        
            let socket:GCDAsyncUdpSocket = factoryUdpSocket(
                configuration:configuration,
                queue:queue)
        
        else
        {
            return nil
        }
        
        let modelUdp:MConnectingSocketUdp = MConnectingSocketUdp(
            socket:socket,
            queue:queue,
            configuration:configuration)
        
        return modelUdp
    }
}
