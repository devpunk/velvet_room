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
        guard
            
            let string:String = String(
                data:data,
                encoding:String.Encoding.utf8)
            
        else
        {
            return
        }
        
        model?.receivedString(string:string)
    }
}
