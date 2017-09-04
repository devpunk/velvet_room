import UIKit
import CocoaAsyncSocket

class MConnect:Model<ArchConnect>
{
    let requestPort:Int = 9309
    var delegate:MConnectDelegate?
    var socket:GCDAsyncUdpSocket?

    func startWireless()
    {
        delegate = MConnectDelegate()
        
        socket = GCDAsyncUdpSocket(
            delegate:delegate,
            delegateQueue:DispatchQueue.global(qos:DispatchQoS.QoSClass.background),
            socketQueue:DispatchQueue.global(qos:DispatchQoS.QoSClass.background))
    }
    
    
}

class MConnectDelegate:NSObject, GCDAsyncUdpSocketDelegate
{
    
}
