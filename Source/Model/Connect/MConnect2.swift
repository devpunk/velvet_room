import Foundation
import CocoaAsyncSocket

class MConnect2
{
    let udpDelegate:MConnect2UDPDelegate
    let udpSocket:GCDAsyncUdpSocket
    let tcpDelegate:MConnect2TCPDelegate
    let tcpSocket:GCDAsyncSocket
    let requestPort:UInt16 = 9309
    var connected:MConnectConnected?
    
    init()
    {
        udpDelegate = MConnect2UDPDelegate()
        tcpDelegate = MConnect2TCPDelegate()
        
        udpSocket = GCDAsyncUdpSocket(
            delegate:udpDelegate,
            delegateQueue:DispatchQueue.global(qos:DispatchQoS.QoSClass.background),
            socketQueue:DispatchQueue.global(qos:DispatchQoS.QoSClass.background))
        
        tcpSocket = GCDAsyncSocket(
            delegate:tcpDelegate, delegateQueue:DispatchQueue.global(qos:DispatchQoS.QoSClass.background), socketQueue: DispatchQueue.global(qos:DispatchQoS.QoSClass.background))
        
        tcpDelegate.connect = self
        
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
        
        do
        {
            try tcpSocket.accept(onPort:requestPort)
        }
        catch let error
        {
            print("error accept on port: \(error.localizedDescription)")
        }
    }
    
    func registred(deviceInfo:DeviceInfo)
    {
        tcpSocket.delegate = nil
        tcpSocket.disconnect()
        
        connected = MConnectConnected(deviceInfo:deviceInfo, connect:self)
        
        DispatchQueue.main.async
        {
            self.connected?.startConnection()
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
        
//        debugPrint(receivingString)
        
        if isInitialConnect(message:receivingString)
        {
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

class MConnect2TCPDelegate:NSObject, GCDAsyncSocketDelegate
{
    weak var connect:MConnect2?
    var acceptedSocket:GCDAsyncSocket?
    var pin:String?
    var deviceInfo:DeviceInfo?

    func socketDidCloseReadStream(_ sock: GCDAsyncSocket) {
        print("did close")
    }
    
    func socket(_ sock: GCDAsyncSocket, didConnectTo url: URL) {
        print("did connect")
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
        
        guard
            
            let receivingString:String = String(
                data:data,
                encoding:String.Encoding.utf8)
            
        else
        {
            return
        }
        
        debugPrint(receivingString)
        
        let method:String? = methodFrom(string:receivingString)
        
        if method == "SHOWPIN"
        {
            pin = generatePin()
            
            print("pin \(pin)")
            
            sendToSocket(socket:sock, string:"HTTP/1.1 200 OK\r\n")
        }
        else if method == "REGISTER"
        {
            let receivedPin:String? = parsePin(string:receivingString)
            
            if receivedPin == pin
            {
                sendToSocket(socket:sock, string:"HTTP/1.1 200 OK\r\n")
            }
            else
            {
                sendToSocket(socket:sock, string:"HTTP/1.1 610 NG\r\n")
            }
        }
        else if method == "REGISTERRESULT" || method == "REGISTERCANCEL"
        {
            // do nothing
        }
        else if method == "CONNECT"
        {
            deviceInfo = parseDeviceInfo(string:receivingString, host:sock.connectedHost)
            
            // if not valid return "HTTP/1.1 605 NG\r\n"
            
            sendToSocket(socket:sock, string:"HTTP/1.1 210 OK\r\n")
        }
        else if method == "STANDBY"
        {
            guard
            
                let deviceInfo:DeviceInfo = self.deviceInfo
            
            else
            {
                print("error device info")
                
                return
            }
            
            acceptedSocket?.delegate = nil
            acceptedSocket?.disconnect()
            
            connect?.registred(deviceInfo:deviceInfo)
        }
    }
    
    func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
        print("did connect")
    }
    
    func socket(_ sock: GCDAsyncSocket, didAcceptNewSocket newSocket: GCDAsyncSocket) {
        print("did accept")
        acceptedSocket = newSocket
        newSocket.readData(withTimeout:100, tag:1)
    }
    
    func socket(_ sock: GCDAsyncSocket, didReadPartialDataOfLength partialLength: UInt, tag: Int) {
        print("did read partial")
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
    
    func methodFrom(string:String) -> String?
    {
        let compo1 = string.components(separatedBy:"\r\n")
        let first = compo1[0]
        let compo2 = first.components(separatedBy:" * HTTP/1.1")
        
        return compo2[0]
    }
    
    func parsePin(string:String) -> String?
    {
        let compo1 = string.components(separatedBy:"\r\n")
        
        for com in compo1
        {
            if com.contains("pin-code")
            {
                let compo2 = com.components(separatedBy:"pin-code:")
                
                return compo2[1]
            }
        }
        
        return nil
    }
    
    func generatePin() -> String
    {
        // length must be exactly 8
        let numberFormatter:NumberFormatter = NumberFormatter()
        numberFormatter.maximumIntegerDigits = 8
        numberFormatter.minimumIntegerDigits = 8
        
        let random:UInt32 = arc4random_uniform(99999999)
        let number:NSNumber = random as NSNumber
        let string:String = numberFormatter.string(from:number)!
        
        return string
    }
    
    func sendToSocket(socket:GCDAsyncSocket, string:String)
    {
        guard
            
            let data:Data = string.data(using:String.Encoding.utf8, allowLossyConversion:false)
            
        else
        {
            return
        }
        
        socket.write(data, withTimeout:100, tag:1957)
        socket.readData(withTimeout:10000, tag:12)
    }
    
    func parseDeviceInfo(string:String, host:String?) -> DeviceInfo?
    {
        let components:[String] = string.components(separatedBy: "\r\n")
        
        var deviceId:String?
        var devicePort:String?
        
        for component:String in components
        {
            if component.contains("device-id")
            {
                let components2:[String] = component.components(separatedBy: "device-id:")
                
                if components2.count > 1
                {
                    deviceId = components2[1]
                }
            }
            else if component.contains("device-port")
            {
                let components2:[String] = component.components(separatedBy: "device-port:")
                
                if components2.count > 1
                {
                    devicePort = components2[1]
                }
            }
        }
        
        guard
        
            let foundId:String = deviceId,
            let foundPort:String = devicePort,
            let foundIp:String = host
        
        else
        {
            return nil
        }
        
        let deviceInfo:DeviceInfo = DeviceInfo(
            deviceId:foundId,
            deviceIp:foundIp,
            dataPort:foundPort)
        
        return deviceInfo
    }
}

struct DeviceInfo
{
    let deviceId:String
    let deviceIp:String
    let dataPort:String
}
