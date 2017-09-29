import Foundation

final class MVitaItemIn
{
    let treat:MVitaItemTreat
    var rawElements:[UInt32]?
    var data:Data?
    var format:MVitaItemFormat?
    var dateModified:Date?
    var name:String?
    var size:UInt64?
    private(set) weak var parent:MVitaItemIn?
    private(set) var elements:[MVitaItemIn]?
    
    init(
        treat:MVitaItemTreat,
        parent:MVitaItemIn?)
    {
        self.treat = treat
        self.parent = parent
    }
    
    //MARK: internal
    
    func addElement(element:MVitaItemIn)
    {
        if elements == nil
        {
            elements = []
        }
        
        elements?.append(element)
    }
}