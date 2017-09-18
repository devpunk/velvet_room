import Foundation
import CocoaAsyncSocket

final class MConnectingSocketUdpDelegate:
    NSObject,
    GCDAsyncUdpSocketDelegate
{
    weak var model:MConnectingSocketUdp?
    
    //MARK: delegate
    
    func udpSocket(
        _ sock:GCDAsyncUdpSocket,
        didReceive data:Data,
        fromAddress address:Data,
        withFilterContext filterContext:Any?)
    {
        guard
        
            let string:String = String(
                data:data,
                encoding:String.Encoding.utf8)
        
        else
        {
            return
        }
        
        DispatchQueue.global(
            qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.model?.receivedString(
                string:string,
                address:address)
        }
    }
}
