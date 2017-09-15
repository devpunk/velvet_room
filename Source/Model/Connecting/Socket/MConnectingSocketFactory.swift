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
        delegate:MConnectingSocketUdpDelegate,
        queue:DispatchQueue,
        configuration:MVitaConfiguration) -> GCDAsyncUdpSocket?
    {
        let socket:GCDAsyncUdpSocket = GCDAsyncUdpSocket(
            delegate:delegate,
            delegateQueue:queue,
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
    
    private class func factoryTcpSocket(
        delegate:MConnectingSocketTcpDelegate,
        queue:DispatchQueue,
        configuration:MVitaConfiguration) -> GCDAsyncSocket?
    {
        let socket:GCDAsyncSocket = GCDAsyncSocket(
            delegate:delegate,
            delegateQueue:queue,
            socketQueue:queue)
        
        do
        {
            try socket.accept(
                onPort:configuration.port)
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
        let delegate:MConnectingSocketUdpDelegate = MConnectingSocketUdpDelegate()
        let queue:DispatchQueue = factoryUdpQueue()
        
        guard
        
            let socket:GCDAsyncUdpSocket = factoryUdpSocket(
                delegate:delegate,
                queue:queue,
                configuration:configuration)
        
        else
        {
            return nil
        }
        
        let modelUdp:MConnectingSocketUdp = MConnectingSocketUdp(
            socket:socket,
            delegate:delegate,
            queue:queue,
            configuration:configuration)
        delegate.model = modelUdp
        
        return modelUdp
    }
}
