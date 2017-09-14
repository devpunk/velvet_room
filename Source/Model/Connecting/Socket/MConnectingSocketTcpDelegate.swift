import Foundation
import CocoaAsyncSocket

final class MConnectingSocketTcpDelegate:
    NSObject,
    GCDAsyncSocketDelegate
{
    weak var model:MConnectingSocketTcp?
}
