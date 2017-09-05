import Foundation
import CocoaAsyncSocket

class MConnect2
{
    let udpDelegate:MConnect2UDPDelegate
    let udpSocket:GCDAsyncUdpSocket
    let requestPort:UInt16 = 9309
    
    init()
    {
        udpDelegate = MConnect2UDPDelegate()
        
        udpSocket = GCDAsyncUdpSocket(
            delegate:udpDelegate,
            delegateQueue:DispatchQueue.global(qos:DispatchQoS.QoSClass.background),
            socketQueue:DispatchQueue.global(qos:DispatchQoS.QoSClass.background))
        
        udpSocket.setIPv6Enabled(false)
        udpSocket.setPreferIPv4()
        
        do
        {
            try udpSocket.bind(toPort:requestPort)
        }
        catch
        {
        }
        
        do
        {
            try udpSocket.beginReceiving()
        }
        catch
        {
        }
        
        do
        {
            try udpSocket.enableReusePort(true)
        }
        catch
        {
        }
    }
}

class MConnect2UDPDelegate:NSObject, GCDAsyncUdpSocketDelegate
{
    func udpSocket(_ sock: GCDAsyncUdpSocket, didReceive data: Data, fromAddress address: Data, withFilterContext filterContext: Any?) {
        
        guard
            
            let receivingString:String = String(
                data:data,
                encoding:String.Encoding.utf8)
            
        else
        {
            return
        }
        
        let host:String? = GCDAsyncUdpSocket.host(fromAddress:address)
        let port:UInt16 = GCDAsyncUdpSocket.port(fromAddress:address)
        
        debugPrint(receivingString)
        
        if isInitialConnect(message:receivingString)
        {
            print("is initial \(host) \(port)")
            
            let replyData:Data = reply()
            
            sock.send(replyData, toAddress:address, withTimeout:100, tag:1)
        }
        else
        {
            print("not initial")
            fatalError()
        }
    }
    
    func reply() -> Data!
    {
        var reply:String = "HTTP/1.1 200 OK\r\n"
        reply.append("host-id:4567890123489\r\n")
        reply.append("host-type:win\r\n")
        reply.append("host-name:vaux\r\n")
        reply.append("host-mtp-protocol-version:01500010\r\n")
        reply.append("host-request-port:9309\r\n")
        reply.append("host-wireless-protocol-version:01000000\r\n")
        reply.append("host-supported-device:PS Vita, PS Vita TV\r\n")
        reply.append("\0")
        
        let data:Data = reply.data(
            using:String.Encoding.utf8, allowLossyConversion:false)!
        
        return data
    }
    
    func isInitialConnect(message:String) -> Bool
    {
        guard
            
            message.starts(with:"SRCH"),
            message.contains(" * HTTP/1.1\r\n")
            
        else
        {
            return false
        }
        
        return true
    }
}
