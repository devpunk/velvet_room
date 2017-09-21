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
        print("accepted \(sock)")
        model?.acceptedConnection(
            acceptedSocket:newSocket)
    }
    
    func socket(
        _ sock:GCDAsyncSocket,
        didRead data:Data,
        withTag tag:Int)
    {
        print("read")
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
    
    func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?) {
        print("error")
        print(err)
    }
}
