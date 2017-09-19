import Foundation
import CocoaAsyncSocket

class MVitaLinkPtpDelegate:
    NSObject,
    GCDAsyncSocketDelegate
{
    //MARK: private
    
    private func read(
        socket:GCDAsyncSocket,
        data:Data)
    {
        
    }
    
    private func asyncRead(socket:GCDAsyncSocket)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            socket.readData(
                withTimeout:0,
                tag:0)
        }
    }
    
    //MARK: delegate
    
    final func socket(
        _ sock:GCDAsyncSocket,
        didRead data:Data,
        withTag tag:Int)
    {
        read(socket:sock, data:data)
    }
}
