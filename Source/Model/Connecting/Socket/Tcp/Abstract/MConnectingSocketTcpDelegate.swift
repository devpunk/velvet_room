import Foundation
import CocoaAsyncSocket

final class MConnectingSocketTcpDelegate:
    NSObject,
    GCDAsyncSocketDelegate
{
    weak var model:MConnectingSocketTcp?
    
    //MARK: delegate
    
    func socket(
        _ sock:GCDAsyncSocket,
        didAcceptNewSocket newSocket:GCDAsyncSocket)
    {
        DispatchQueue.global(
            qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.model?.acceptedConnection(
                acceptedSocket:newSocket)
        }
    }
    
    func socket(
        _ sock:GCDAsyncSocket,
        didRead data:Data,
        withTag tag:Int)
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
            
            self?.model?.receivedString(string:string)
        }
    }
}
