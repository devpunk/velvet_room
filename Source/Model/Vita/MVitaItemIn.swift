import Foundation

class MVitaItemIn
{
    let treat:MVitaItemTreat
    var rawElements:[UInt32]?
    var data:Data?
    var format:MVitaItemFormat?
    var dateModified:Date?
    var size:UInt64?
    var thumbnail:Data?
    private(set) weak var parent:MVitaItemIn?
    private(set) var elements:[MVitaItemIn]?
    private(set) var name:String?
    private(set) var fileExtension:MVitaItemInExtension
    
    init(
        treat:MVitaItemTreat,
        parent:MVitaItemIn?)
    {
        self.treat = treat
        self.parent = parent
        fileExtension = MVitaItemInExtension.unknown
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
    
    func addName(name:String)
    {
        let fileExtension:MVitaItemInExtension = MVitaItemInExtension.factoryExtension(
            name:name)
        
        self.name = name
        self.fileExtension = fileExtension
    }
}
