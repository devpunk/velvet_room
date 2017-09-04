import UIKit
import CocoaAsyncSocket

class MConnect:Model<ArchConnect>
{
    let requestPort:UInt16 = 9309
    var delegate:MConnectDelegate?
    var socket:GCDAsyncUdpSocket?

    func startWireless()
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
        
        print("did receive from: \(host) \(port)")
        print(receivingString)
    }
}
