import Foundation

final class MVitaItemInElement:MVitaItemIn
{
    var data:Data?
    var size:UInt64?
    var fileExtension:MVitaItemInExtension
    private(set) weak var parent:MVitaItemInDirectory?
    
    init(
        parent:MVitaItemInDirectory,
        treatId:UInt32)
    {
        self.parent = parent
        fileExtension = MVitaItemInExtension.unknown
        
        super.init(
            format:MVitaItemFormat.element,
            treatId:treatId)
    }
}
