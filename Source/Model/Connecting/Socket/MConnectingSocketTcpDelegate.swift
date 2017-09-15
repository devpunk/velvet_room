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
        didRead data:Data,
        withTag tag:Int)
    {
        
    }
}
