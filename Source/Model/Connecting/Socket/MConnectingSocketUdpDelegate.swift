import Foundation
import CocoaAsyncSocket

final class MConnectingSocketUdpDelegate:
    NSObject,
    GCDAsyncUdpSocketDelegate
{
    weak var model:MConnectingSocketUdp?
}
