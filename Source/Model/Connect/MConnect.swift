import UIKit
import CocoaAsyncSocket

class MConnect:Model<ArchConnect>
{
    let requestPort:UInt16 = 9309
    var delegate:MConnectDelegate?
    var delegateClient:MConnectDelegateClient?
    var delegateServerClient:MConnectDelegateServerClient?
    var socket:GCDAsyncUdpSocket?
    var tcpSocket:GCDAsyncSocket?
    var delegateTcp:tcpDelegate?
    var clientSockets:[GCDAsyncUdpSocket]?
    var connect2:MConnect2?
    
    func startWireless()
    {
        guard
        
            connect2 == nil
        
        else
        {
            return
        }
        
        connect2 = MConnect2()
        print("start")
    }
    
    func startTcp()
    {
        delegateTcp = tcpDelegate()
        tcpSocket = GCDAsyncSocket(
            delegate:delegateTcp, delegateQueue:DispatchQueue.global(qos:DispatchQoS.QoSClass.background), socketQueue: DispatchQueue.global(qos:DispatchQoS.QoSClass.background))
        
        do
        {
            try tcpSocket?.connect(toHost:"192.168.0.11", onPort:9309)
        }
        catch let error
        {
            print("error con: \(error.localizedDescription)")
        }
    }
    
    func startServerClient()
    {
        guard
            
            socket == nil
            
        else
        {
            return
        }
        
        delegateServerClient = MConnectDelegateServerClient()
        
        socket = GCDAsyncUdpSocket(
            delegate:delegateServerClient,
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
    
    func startClient()
    {
        if delegateClient == nil
        {
            delegateClient = MConnectDelegateClient()
            clientSockets = []
        }
        
        let socket:GCDAsyncUdpSocket = GCDAsyncUdpSocket(
            delegate:delegateClient,
            delegateQueue:DispatchQueue.global(qos:DispatchQoS.QoSClass.background),
            socketQueue:DispatchQueue.global(qos:DispatchQoS.QoSClass.background))

        do
        {
            try socket.enableReusePort(true)
        }
        catch let error
        {
            print("problem reusing: \(error.localizedDescription)")
        }
        
        delegateClient?.sendInitial(socket:socket, tag:clientSockets!.count)
        
        do
        {
            try socket.beginReceiving()
        }
        catch let error
        {
            print("problem begin: \(error.localizedDescription)")
        }
        
        clientSockets?.append(socket)
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
        
        socket?.setIPv6Enabled(false)
        socket?.setPreferIPv4()
        
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
    var sentInitial:Bool = false
    
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
            print("is initial \(host) \(port)")
            
            let replyData:Data
            
            if sentInitial
            {
                replyData = replyUnavailable()!
            }
            else
            {
//                sentInitial = true
                replyData = reply()!
            }
            
            sock.send(replyData, toAddress:address, withTimeout:1000, tag:1)
        }
        else
        {
            print("not initial")
            fatalError()
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
        
        
//        reply = "HTTP/1.1 200 OK\r\nhost-id:bdca08f8-607e-4816-8448-d4f58919109a\r\nhost-type:mac\r\nhost-name:vaux\r\nhost-mtp-protocol-version:01900010\r\nhost-request-port:9309\r\nhost-wireless-protocol-version:01000000\r\nhost-supported-device:PS Vita, PS Vita TV\r\n\0"
        
//        debugPrint(reply)
        
        let data:Data? = reply.data(
        using:String.Encoding.utf8, allowLossyConversion:false)
        
        return data
    }
    
    func replyUnavailable() -> Data?
    {
        var reply:String = "HTTP/1.1 503 NG\r\n"
        reply.append("host-id:4567890123489\r\n")
        reply.append("host-type:win\r\n")
        reply.append("host-name:vaux2\r\n")
        reply.append("host-mtp-protocol-version:01500010\r\n")
        reply.append("host-request-port:9309\r\n")
        reply.append("host-wireless-protocol-version:01000000\r\n")
        reply.append("host-supported-device:PS Vita, PS Vita TV\r\n")
        reply.append("\0")
        
        
        //        reply = "HTTP/1.1 200 OK\r\nhost-id:bdca08f8-607e-4816-8448-d4f58919109a\r\nhost-type:mac\r\nhost-name:vaux\r\nhost-mtp-protocol-version:01900010\r\nhost-request-port:9309\r\nhost-wireless-protocol-version:01000000\r\nhost-supported-device:PS Vita, PS Vita TV\r\n\0"
        
        //        debugPrint(reply)
        
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
    func sendInitial(socket:GCDAsyncUdpSocket?, tag:Int)
    {
        let data:Data = reply()!
        
        socket?.send(
            data,
            toHost:"192.168.0.11",
            port:9309,
            withTimeout:100,
            tag:tag)
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
        
        print("\(host!) : \(port) : \(sock.localPort())")
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





class MConnectDelegateServerClient:NSObject, GCDAsyncUdpSocketDelegate
{
    var socket:GCDAsyncUdpSocket?
    var delegate:MConnectDelegateClientClient?
    var sentInitial:Bool = false
    
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
        
        let host:String = GCDAsyncUdpSocket.host(fromAddress:address)!
        let port:UInt16 = GCDAsyncUdpSocket.port(fromAddress:address)
        
        if isInitialConnect(message:receivingString)
        {
            if !sentInitial
            {
                debugPrint(receivingString)
                sentInitial = true

                delegate = MConnectDelegateClientClient(host:host, port:port)
                
                socket = GCDAsyncUdpSocket(
                    delegate:delegate,
                    delegateQueue:DispatchQueue.global(qos:DispatchQoS.QoSClass.background),
                    socketQueue:DispatchQueue.global(qos:DispatchQoS.QoSClass.background))

                
                do
                {
                    try socket?.enableReusePort(true)
                }
                catch let error
                {
                    print("problem reusing: \(error.localizedDescription)")
                }
                
                delegate?.sendInitial(socket:socket)
            }
            else
            {
                delegate?.actuallySend(socket:socket)
            }
        }
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




class MConnectDelegateClientClient:NSObject, GCDAsyncUdpSocketDelegate
{
    let host:String
    let port:UInt16
    var address: Data?
    
    init(host:String, port:UInt16)
    {
        self.host = host
        self.port = port
    }
    
    func actuallySend(socket:GCDAsyncUdpSocket?)
    {
        guard
            
            let address:Data = self.address
        
        else
        {
            return
        }
        
        let data:Data = reply()!
        
        socket?.send(data, toAddress: address, withTimeout:1000, tag: 12)
    }
    
    func sendInitial(socket:GCDAsyncUdpSocket?)
    {
        do
        {
            try socket?.connect(toHost:host, onPort:port)
        }
        catch let error
        {
            print("error connect \(error.localizedDescription)")
        }
        
        do
        {
            try socket?.beginReceiving()
        }
        catch let error
        {
            print("problem begin: \(error.localizedDescription)")
        }
        
        print("begin")
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
        self.address = address
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
            let data:Data = reply()!
            
            sock.send(
                data,
                toHost:self.host,
                port:self.port,
                withTimeout:100,
                tag:123)
        }
    }
    
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
        
        
        //        reply = "HTTP/1.1 200 OK\r\nhost-id:bdca08f8-607e-4816-8448-d4f58919109a\r\nhost-type:mac\r\nhost-name:vaux\r\nhost-mtp-protocol-version:01900010\r\nhost-request-port:9309\r\nhost-wireless-protocol-version:01000000\r\nhost-supported-device:PS Vita, PS Vita TV\r\n\0"
        
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


class tcpDelegate:NSObject, GCDAsyncSocketDelegate
{
    func reply() -> Data
    {
        let reply:String = "SRCH3 * HTTP/1.1\r\ndevice-id:681401e7aed501010101010101010101\r\ndevice-type:PS Vita\r\ndevice-class:0\r\ndevice-mac-address:681401e7aed5\r\ndevice-wireless-protocol-version:01000000\r\n\r\n"
        let data:Data = reply.data(
            using:String.Encoding.utf8, allowLossyConversion:false)!
        
        return data
    }
    
    func socketDidCloseReadStream(_ sock: GCDAsyncSocket) {
        print("did close")
    }
    
    func socket(_ sock: GCDAsyncSocket, didConnectTo url: URL) {
        print("did connet")
    }
    
    func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?) {
        print("did disconnect")
    }
    
    func socket(_ sock: GCDAsyncSocket, didWriteDataWithTag tag: Int) {
        print("did write")
    }
    
    func socketDidSecure(_ sock: GCDAsyncSocket) {
        print("did secure")
    }
    
    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        print("did read")
    }
    
    func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
        print("did connect")
        
        sock.write(reply(), withTimeout:100, tag:12)
    }
    
    func socket(_ sock: GCDAsyncSocket, didAcceptNewSocket newSocket: GCDAsyncSocket) {
        print("did accept")
    }
    
    func socket(_ sock: GCDAsyncSocket, didReadPartialDataOfLength partialLength: UInt, tag: Int) {
        print("did read")
    }
    
    func socket(_ sock: GCDAsyncSocket, didWritePartialDataOfLength partialLength: UInt, tag: Int) {
        print("print did write")
    }
    
    func socket(_ sock: GCDAsyncSocket, didReceive trust: SecTrust, completionHandler: @escaping (Bool) -> Void) {
        print("did receive")
    }
    
    func socket(_ sock: GCDAsyncSocket, shouldTimeoutReadWithTag tag: Int, elapsed: TimeInterval, bytesDone length: UInt) -> TimeInterval {
        print("should time")
        
        return 1
    }
    
    func socket(_ sock: GCDAsyncSocket, shouldTimeoutWriteWithTag tag: Int, elapsed: TimeInterval, bytesDone length: UInt) -> TimeInterval {
        print("should")
        
        return 1
    }
    
    func newSocketQueueForConnection(fromAddress address: Data, on sock: GCDAsyncSocket) -> DispatchQueue? {
        print("new queue")
        
        return nil
    }
}
