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
    
    }
    
    func socketDidDisconnect(
        _ sock:GCDAsyncSocket,
        withError err:Error?)
    {
        
    }
}
