import UIKit
import CocoaAsyncSocket

class MConnect:Model<ArchConnect>, GCDAsyncUdpSocketDelegate
{
    let requestPort:Int = 9309
    var socket:GCDAsyncUdpSocket?

    func startWireless()
    {
        socket = GCDAsyncUdpSocket(
            delegate:self,
            delegateQueue:DispatchQueue.global(qos:DispatchQoS.QoSClass.background),
            socketQueue:DispatchQueue.global(qos:DispatchQoS.QoSClass.background))
    }
}
