import Foundation
import CocoaAsyncSocket

final class MVitaLinkCommandDelegate:
    NSObject,
    GCDAsyncSocketDelegate
{
    weak var model:MVitaLinkCommand?
}
