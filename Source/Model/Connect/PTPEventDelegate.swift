import Foundation
import CocoaAsyncSocket

class PTPEventDelegate:NSObject, GCDAsyncSocketDelegate
{
    weak var connected:MConnectConnected?
}
