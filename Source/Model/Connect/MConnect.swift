import UIKit
import CocoaAsyncSocket

class MConnect:Model<ArchConnect>
{
    let requestPort:UInt16 = 9309
    var delegate:MConnectDelegate?
    var delegateClient:MConnectDelegateClient?
    var socket:GCDAsyncUdpSocket?

    func startWireless()
    {
        startServer()
    }
    
    func startClient()
    {
        guard
            
            socket == nil
            
        else
        {
            delegateClient?.sendInitial(socket:socket)
            
            do
            {
                try socket?.beginReceiving()
            }
            catch let error
            {
                print("problem begin: \(error.localizedDescription)")
            }
            
            return
        }
        
        delegateClient = MConnectDelegateClient()
        
        socket = GCDAsyncUdpSocket(
            delegate:delegateClient,
            delegateQueue:DispatchQueue.global(qos:DispatchQoS.QoSClass.background),
            socketQueue:DispatchQueue.global(qos:DispatchQoS.QoSClass.background))
        
//        do
//        {
//            try socket?.bind(toPort:requestPort)
//        }
//        catch let error
//        {
//            print("problem binding: \(error.localizedDescription)")
//        }
        
        
        
        do
        {
            try socket?.enableReusePort(true)
        }
        catch let error
        {
            print("problem reusing: \(error.localizedDescription)")
        }
        
        print("ready")
    }
    
    func startServer()
    {
        guard
            
            socket == nil
            
        else
        {
            return
        }
        
        delegate = MConnectDelegate()
        
        socket = GCDAsyncUdpSocket(
            delegate:delegate,
            delegateQueue:DispatchQueue.global(qos:DispatchQoS.QoSClass.background),
            socketQueue:DispatchQueue.global(qos:DispatchQoS.QoSClass.background))
        
        do
        {
            try socket?.bind(toPort:requestPort)
        }
        catch let error
        {
            print("problem binding: \(error.localizedDescription)")
        }
        
        do
        {
            try socket?.beginReceiving()
        }
        catch let error
        {
            print("problem begin: \(error.localizedDescription)")
        }
        
        do
        {
            try socket?.enableReusePort(true)
        }
        catch let error
        {
            print("problem reusing: \(error.localizedDescription)")
        }
        
        print("ready")
    }
}

class MConnectDelegate:NSObject, GCDAsyncUdpSocketDelegate
{
    func udpSocket(_ sock: GCDAsyncUdpSocket, didNotConnect error: Error?) {
        print("did not connect")
    }
    
    func udpSocket(_ sock: GCDAsyncUdpSocket, didSendDataWithTag tag: Int) {
        print("send data")
    }
    
    func udpSocketDidClose(_ sock: GCDAsyncUdpSocket, withError error: Error?) {
        print("close")
    }
    
    func udpSocket(_ sock: GCDAsyncUdpSocket, didConnectToAddress address: Data) {
        print("did connect")
    }
    
    func udpSocket(_ sock: GCDAsyncUdpSocket, didNotSendDataWithTag tag: Int, dueToError error: Error?) {
        print("did not send data")
    }
    
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
            print("is initial")
            
            guard
                
                let replyData:Data = reply()
            
            else
            {
                print("error reply data")
                return
            }
            
            sock.send(replyData, toAddress:address, withTimeout:100, tag:99)
        }
    }
    
    //MARK: -
    
    func reply() -> Data?
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
        
        
        reply = "HTTP/1.1 200 OK\r\nhost-id:bdca08f8-607e-4816-8448-d4f58919107a\r\nhost-type:mac\r\nhost-name:vaux\r\nhost-mtp-protocol-version:01900010\r\nhost-request-port:9309\r\nhost-wireless-protocol-version:01000000\r\nhost-supported-device:PS Vita, PS Vita TV\r\n\0"
        
        let data:Data? = reply.data(
        using:String.Encoding.utf8, allowLossyConversion:false)
        
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

class MConnectDelegateClient:NSObject, GCDAsyncUdpSocketDelegate
{
    func sendInitial(socket:GCDAsyncUdpSocket?)
    {
        let data:Data = reply()!
        
        socket?.send(
            data,
            toHost:"192.168.0.11",
            port:9309,
            withTimeout:100,
            tag:123)
    }
    
    func udpSocket(_ sock: GCDAsyncUdpSocket, didNotConnect error: Error?) {
        print("did not connect")
    }
    
    func udpSocket(_ sock: GCDAsyncUdpSocket, didSendDataWithTag tag: Int) {
        print("send data")
    }
    
    func udpSocketDidClose(_ sock: GCDAsyncUdpSocket, withError error: Error?) {
        print("close")
    }
    
    func udpSocket(_ sock: GCDAsyncUdpSocket, didConnectToAddress address: Data) {
        print("did connect")
    }
    
    func udpSocket(_ sock: GCDAsyncUdpSocket, didNotSendDataWithTag tag: Int, dueToError error: Error?) {
        print("did not send data")
    }
    
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
    }
    
    func reply() -> Data?
    {
        let reply:String = "SRCH3 * HTTP/1.1\r\ndevice-id:681401e7aed501010101010101010101\r\ndevice-type:PS Vita\r\ndevice-class:0\r\ndevice-mac-address:681401e7aed5\r\ndevice-wireless-protocol-version:01000000\r\n\r\n"
        
        let data:Data? = reply.data(
            using:String.Encoding.utf8, allowLossyConversion:false)
        
        return data
    }
}
