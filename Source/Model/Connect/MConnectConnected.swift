import Foundation
import CocoaAsyncSocket

class MConnectConnected
{
    weak var connect:MConnect2?
    let deviceInfo:DeviceInfo
    let commandDelegate:SocketCommandDelegate
    let eventDelegate:SocketEventDelegate
    var socketCommand:GCDAsyncSocket?
    var socketEvent:GCDAsyncSocket?
    
    init(deviceInfo:DeviceInfo, connect:MConnect2)
    {
        self.deviceInfo = deviceInfo
        self.connect = connect
        commandDelegate = SocketCommandDelegate()
        eventDelegate = SocketEventDelegate()
        
        commandDelegate.connected = self
        eventDelegate.connected = self
    }
    
    func startConnection()
    {
        socketCommand = GCDAsyncSocket(
            delegate:commandDelegate, delegateQueue:DispatchQueue.global(qos:DispatchQoS.QoSClass.background), socketQueue: DispatchQueue.global(qos:DispatchQoS.QoSClass.background))
        
        socketEvent = GCDAsyncSocket(
            delegate:eventDelegate, delegateQueue:DispatchQueue.global(qos:DispatchQoS.QoSClass.background), socketQueue: DispatchQueue.global(qos:DispatchQoS.QoSClass.background))
        
        do
        {
            try socketCommand?.accept(onPort:UInt16(deviceInfo.dataPort)!)
        }
        catch let error
        {
            print("error accept on port: \(error.localizedDescription)")
        }
        
        do
        {
            try socketEvent?.accept(onPort:UInt16(deviceInfo.dataPort)!)
        }
        catch let error
        {
            print("error accept on port: \(error.localizedDescription)")
        }
    }
}

class SocketCommandDelegate:NSObject, GCDAsyncSocketDelegate
{
    weak var connected:MConnectConnected?
    
    func socketDidCloseReadStream(_ sock: GCDAsyncSocket) {
        print("command did close")
    }
    
    func socket(_ sock: GCDAsyncSocket, didConnectTo url: URL) {
        print("command did connect")
    }
    
    func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?) {
        print("command did disconnect")
    }
    
    func socket(_ sock: GCDAsyncSocket, didWriteDataWithTag tag: Int) {
        print("command did write")
    }
    
    func socketDidSecure(_ sock: GCDAsyncSocket) {
        print("command did secure")
    }
    
    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        print("command did read")
        
        guard
            
            let receivingString:String = String(
                data:data,
                encoding:String.Encoding.utf8)
            
        else
        {
            return
        }
        
        debugPrint(receivingString)
    }
    
    func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
        print("command did connect")
    }
    
    func socket(_ sock: GCDAsyncSocket, didAcceptNewSocket newSocket: GCDAsyncSocket) {
        print("command did accept")
    }
    
    func socket(_ sock: GCDAsyncSocket, didReadPartialDataOfLength partialLength: UInt, tag: Int) {
        print("command did read partial")
    }
    
    func socket(_ sock: GCDAsyncSocket, didWritePartialDataOfLength partialLength: UInt, tag: Int) {
        print("command print did write")
    }
    
    func socket(_ sock: GCDAsyncSocket, didReceive trust: SecTrust, completionHandler: @escaping (Bool) -> Void) {
        print("command did receive")
    }
    
    func socket(_ sock: GCDAsyncSocket, shouldTimeoutReadWithTag tag: Int, elapsed: TimeInterval, bytesDone length: UInt) -> TimeInterval {
        print("command should time")
        
        return 1
    }
    
    func socket(_ sock: GCDAsyncSocket, shouldTimeoutWriteWithTag tag: Int, elapsed: TimeInterval, bytesDone length: UInt) -> TimeInterval {
        print("command should")
        
        return 1
    }
    
    func newSocketQueueForConnection(fromAddress address: Data, on sock: GCDAsyncSocket) -> DispatchQueue? {
        print("command new queue")
        
        return nil
    }
}

class SocketEventDelegate:NSObject, GCDAsyncSocketDelegate
{
    weak var connected:MConnectConnected?
    
    func socketDidCloseReadStream(_ sock: GCDAsyncSocket) {
        print("event did close")
    }
    
    func socket(_ sock: GCDAsyncSocket, didConnectTo url: URL) {
        print("event did connect")
    }
    
    func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?) {
        print("event did disconnect")
    }
    
    func socket(_ sock: GCDAsyncSocket, didWriteDataWithTag tag: Int) {
        print("event did write")
    }
    
    func socketDidSecure(_ sock: GCDAsyncSocket) {
        print("event did secure")
    }
    
    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        print("event did read")
        
        guard
            
            let receivingString:String = String(
                data:data,
                encoding:String.Encoding.utf8)
            
            else
        {
            return
        }
        
        debugPrint(receivingString)
    }
    
    func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
        print("event did connect")
    }
    
    func socket(_ sock: GCDAsyncSocket, didAcceptNewSocket newSocket: GCDAsyncSocket) {
        print("event did accept")
    }
    
    func socket(_ sock: GCDAsyncSocket, didReadPartialDataOfLength partialLength: UInt, tag: Int) {
        print("event did read partial")
    }
    
    func socket(_ sock: GCDAsyncSocket, didWritePartialDataOfLength partialLength: UInt, tag: Int) {
        print("event print did write")
    }
    
    func socket(_ sock: GCDAsyncSocket, didReceive trust: SecTrust, completionHandler: @escaping (Bool) -> Void) {
        print("event did receive")
    }
    
    func socket(_ sock: GCDAsyncSocket, shouldTimeoutReadWithTag tag: Int, elapsed: TimeInterval, bytesDone length: UInt) -> TimeInterval {
        print("event should time")
        
        return 1
    }
    
    func socket(_ sock: GCDAsyncSocket, shouldTimeoutWriteWithTag tag: Int, elapsed: TimeInterval, bytesDone length: UInt) -> TimeInterval {
        print("event should")
        
        return 1
    }
    
    func newSocketQueueForConnection(fromAddress address: Data, on sock: GCDAsyncSocket) -> DispatchQueue? {
        print("event new queue")
        
        return nil
    }
}
