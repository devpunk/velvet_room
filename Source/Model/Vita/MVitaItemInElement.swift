import Foundation

final class MVitaItemInElement:MVitaItemIn
{
    var data:Data?
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
    
    override func requestContent(
        strategy:MVitaLinkStrategyRequestItemTreat)
    {
        strategy.requestItemData(
            treatId:treatId)
    }
    
    override var name:String?
    {
        didSet
        {
            updateExtension()
        }
    }
    
    //MARK: private
    
    private func updateExtension()
    {
        guard
        
            let name:String = self.name
        
        else
        {
            return
        }
        
        fileExtension = MVitaItemInExtension.factoryExtension(
            name:name)
    }
}
