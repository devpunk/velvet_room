import Foundation
import CocoaAsyncSocket

final class MVitaLinkCommandDelegate:
    NSObject,
    GCDAsyncSocketDelegate
{
    weak var model:MVitaLinkCommand?
    
    //MARK: delegate
    
    func socket(
        _ sock:GCDAsyncSocket,
        didConnectToHost host:String,
        port:UInt16)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.model?.model?.strategy?.commandConnected()
        }
    }
    
    func socketDidDisconnect(
        _ sock:GCDAsyncSocket,
        withError err:Error?)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.model?.model?.strategy?.commandDisconnected()
        }
    }
}
