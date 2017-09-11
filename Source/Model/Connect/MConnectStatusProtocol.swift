import Foundation

protocol MConnectStatusProtocol
{
    var viewType:View<ArchConnect>.Type { get }
    
    init(model:MConnect)
}
