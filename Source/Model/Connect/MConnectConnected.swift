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
    
    let ptpLength:Int = 24
    let ptpip_type:Int = 4
    let ptpip_len:Int = 0
    let ptpip_initcmd_guid:Int = 8
    let ptpip_initcmd_name:CUnsignedChar = 24
    let PTPIP_INIT_COMMAND_REQUEST:CUnsignedChar =   1
    let PTPIP_INIT_COMMAND_ACK     =   2
    let PTPIP_INIT_EVENT_REQUEST   = 3
    let PTPIP_INIT_EVENT_ACK       = 4
    
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
        
        connectCommand()
    }
    
    func commandDisconnected()
    {
        if socketEvent == nil
        {
            connectCommand()
        }
    }
    
    func connectCommand()
    {
        let port:UInt16 = UInt16(deviceInfo.dataPort)!
        
        do
        {
            try socketCommand?.connect(
                toHost:deviceInfo.deviceIp,
                onPort:port)
        }
        catch let error
        {
            print("error connect command: \(error.localizedDescription)")
        }
        
        print("command connect")
    }
    
    func commandConnected()
    {
        socketEvent = GCDAsyncSocket(
            delegate:eventDelegate, delegateQueue:DispatchQueue.global(qos:DispatchQoS.QoSClass.background), socketQueue: DispatchQueue.global(qos:DispatchQoS.QoSClass.background))
        
        let port:UInt16 = UInt16(deviceInfo.dataPort)!
        
        do
        {
            try socketEvent?.connect(
                toHost:deviceInfo.deviceIp,
                onPort:port)
        }
        catch let error
        {
            print("error connect event: \(error.localizedDescription)")
        }
        
        print("event connect")
    }
    
    func eventConnected()
    {
        commandRequest()
        commandAck()
    }
    
    func commandRequest()
    {
//        var request:[CUnsignedChar] = [CUnsignedChar](repeating:0, count:8)
//        let guid:[CUnsignedChar] = [CUnsignedChar](repeatElement(0, count:16))
//
//        request[ptpip_type] = PTPIP_INIT_COMMAND_REQUEST
//        request[ptpip_len] = 8
//        request.append(contentsOf:guid)
        
        var request:[UInt32] = [16,1,0,0,0,0]
        
        let data = Data(buffer: UnsafeBufferPointer(start: &request, count: request.count))
        
        socketCommand?.write(data, withTimeout:100, tag:0)
    }
    
    func commandAck()
    {
        socketCommand?.readData(withTimeout:1000, tag:0)
        
        // "\u{0C}\0\0\0\u{02}\0\0\0\0\0\0\0"
    }
    
    func commandAckRead()
    {
        let eventRequest:UInt32 = 3
        let pipeId:UInt32 = 0
        var request:[UInt32] = [12,eventRequest,pipeId]
        
        let data = Data(buffer: UnsafeBufferPointer(start: &request, count: request.count))
        
        socketEvent?.write(data, withTimeout:100, tag:0)
    }
    
    func eventRead()
    {
        socketEvent?.readData(withTimeout:1000, tag:0)
    }
    
    func eventReady()
    {
        
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
        print(connected?.deviceInfo)
        print("command did disconnect error \(err?.localizedDescription)")
        
        connected?.commandDisconnected()
    }
    
    func socket(_ sock: GCDAsyncSocket, didWriteDataWithTag tag: Int) {
        print("command did write")
    }
    
    func socketDidSecure(_ sock: GCDAsyncSocket) {
        print("command did secure")
    }
    
    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        print("command did read")
        
        if data.count != 12
        {
            print("error reading header, must be 12 bytes")
        }
        
        let arr2 = data.withUnsafeBytes {
            Array(UnsafeBufferPointer<UInt32>(start: $0, count: data.count/MemoryLayout<UInt32>.size))
        }
        
        // 0: length, 1: ack (should be 2), 2: eventpipeid
        
        print(arr2)
        
        connected?.commandAckRead()
    }
    
    func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
        print("command did connect")
        
        connected?.commandConnected()
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
        
        connected?.eventRead()
    }
    
    func socketDidSecure(_ sock: GCDAsyncSocket) {
        print("event did secure")
    }
    
    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        print("event did read")
        
        if data.count != 8
        {
            print("error reading header, must be 12 bytes")
        }
        
        let arr2 = data.withUnsafeBytes {
            Array(UnsafeBufferPointer<UInt32>(start: $0, count: data.count/MemoryLayout<UInt32>.size))
        }
        
        // 0: length, 1: ack (should be 4)
        
        print(arr2)
        
        connected?.eventReady()
    }
    
    func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
        print("event did connect")
        
        connected?.eventConnected()
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


struct PTPContainer {
    var Code:UInt16 = 0
    var SessionID:UInt32 = 0
    var Transaction_ID:UInt32 = 0
    /* params  may be of any type of size less or equal to uint32_t */
    var Param1:UInt32 = 0
    var Param2:UInt32 = 0
    var Param3:UInt32 = 0
    /* events can only have three parameters */
    var Param4:UInt32 = 0
    var Param5:UInt32 = 0
    /* the number of meaningfull parameters */
    var Nparam:UInt8 = 0
};
