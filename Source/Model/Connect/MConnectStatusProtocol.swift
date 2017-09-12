import Foundation

protocol MConnectStatusProtocol
{
    var viewType:View<ArchConnect>.Type { get }
    var shouldStart:Bool { get }
    
    init(model:MConnect)
}
