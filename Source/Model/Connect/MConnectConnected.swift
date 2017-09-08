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
//        let openSession:UInt16 = 4098
//        var container:PTPContainer = PTPContainer()
//        container.Code = openSession
//        container.Param1 = 1 // session id =1
//        container.Nparam = 1
        
        
        var code:UInt16 = 4098 //ptpip_cmd_code
        let type:UInt32 = 6 // PTPIP_CMD_REQUEST
        let dataPhase:UInt32 = 1//ptpip_cmd_dataphase
        let tranId:UInt32 = 1//ptpip_cmd_transid
        let par1:UInt32 = 0//ptpip_cmd_param1, session id, 0 to connect
        
        var request:[UInt32] = [22,type,dataPhase]
        var transSession:[UInt32] = [tranId, par1]
        
        var data = Data(buffer: UnsafeBufferPointer(start: &request, count: request.count))
        
        data.append(UnsafeBufferPointer(start:&code, count:1))
        data.append(UnsafeBufferPointer(start: &transSession, count: transSession.count))
        
        socketCommand?.write(data, withTimeout:100, tag:0)
        socketCommand?.readData(withTimeout:1000, tag:0)
    }
    
    func eventReadDataConnection()
    {
        connect?.stopBroadcast()
        
        
        var code:UInt16 = 38161 //PTP_OC_VITA_GetVitaInfo
        let type:UInt32 = 6 // PTPIP_CMD_REQUEST
        let dataPhase:UInt32 = 1//ptpip_cmd_dataphase
        var tranId:UInt32 = 2//ptpip_cmd_transid
        
        var request:[UInt32] = [18,type,dataPhase]
        
        var data = Data(buffer: UnsafeBufferPointer(start: &request, count: request.count))
        data.append(UnsafeBufferPointer(start:&code, count:1))
        data.append(UnsafeBufferPointer(start: &tranId, count: 1))
        
        socketCommand?.write(data, withTimeout:100, tag:0)
        socketCommand?.readData(withTimeout:1000, tag:0)
    }
}

class SocketCommandDelegate:NSObject, GCDAsyncSocketDelegate
{
    var step:Int = 0
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
        
        if step == 0
        {
            step = 1
            
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
        else if step == 1
        {
            step = 2
            let header = data.withUnsafeBytes {
                
                Array(UnsafeBufferPointer<UInt32>(start: $0, count: 2))
            }
            
            let sub:Data = data.subdata(in: 8..<10)
            
            let arrCode = sub.withUnsafeBytes {
                
                Array(UnsafeBufferPointer<UInt16>(start: $0, count: 1))
            }
            
            let sub2:Data = data.subdata(in: 10..<14)
            
            let arrParameter = sub2.withUnsafeBytes {
                
                Array(UnsafeBufferPointer<UInt32>(start: $0, count: 1))
            }
            
            //[size:14, response:7, code: 8193 (ok), transactionId:1]
            
            // par 1 == tranid
            print("header:\(header)")
            print("code: \(arrCode) par:\(arrParameter)")
            
            connected?.eventReadDataConnection()
        }
        else if step == 2
        {
            step = 3
            
            let header = data.withUnsafeBytes {
                
                Array(UnsafeBufferPointer<UInt32>(start: $0, count: 5))
            }
            
            //[size:16, response:9 // PTPIP_START_DATA_PACKET, transactionId:2, payload]
            
            //header and payload:[14, 7, 139267, 0]
            //header and payload:[14, 7, 204803, 0, 0]
            //header and payload:[14, 7, 139267, 0, 1879633920]
            
            print("header and payload:\(header)")
            
            sock.readData(withTimeout:1000, tag:0)
        }
        else if step == 3
        {
            step = 4
            
            let header = data.withUnsafeBytes {
                
                Array(UnsafeBufferPointer<UInt32>(start: $0, count: 2))
            }
            
            //[size, response:10 or 12, PTPIP_DATA_PACKET]
            
            print("data:\(header)")
            
            // size should be equal to payload if not read again if true read to next step
            
            sock.readData(withTimeout:1000, tag:0)
            
            guard
                
                let receivingString:String = String(
                    data:data,
                    encoding:String.Encoding.utf8)
                
                else
            {
                return
            }
            
            print("data in xml:")
            print(receivingString)
        }
        else if step == 4
        {
            step = 5
            
            step = 2
            let header = data.withUnsafeBytes {
                
                Array(UnsafeBufferPointer<UInt32>(start: $0, count: 2))
            }
            
            let sub:Data = data.subdata(in: 8..<10)
            
            let arrCode = sub.withUnsafeBytes {
                
                Array(UnsafeBufferPointer<UInt16>(start: $0, count: 1))
            }
            
            let sub2:Data = data.subdata(in: 10..<14)
            
            let arrParameter = sub2.withUnsafeBytes {
                
                Array(UnsafeBufferPointer<UInt32>(start: $0, count: 1))
            }
            
            //[size:14, response:7, code: 8193 (ok), transactionId:1]
            
            // par 1 == tranid
            print("finish data header:\(header)")
            print("code: \(arrCode) par:\(arrParameter)")
            
            // response should be xml
            
        }
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

