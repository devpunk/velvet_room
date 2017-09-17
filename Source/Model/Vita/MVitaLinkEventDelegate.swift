import Foundation
import CocoaAsyncSocket

final class MVitaLinkEventDelegate:
    NSObject,
    GCDAsyncSocketDelegate
{
    weak var model:MVitaLinkEvent?
}
