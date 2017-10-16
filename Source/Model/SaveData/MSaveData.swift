import Foundation

final class MSaveData:Model<ArchSaveData>
{
    private(set) var content:[MSaveDataProtocol]
    
    required init()
    {
        content = []
        
        super.init()
    }
    
    weak var item:MHomeSaveDataItem?
    {
        didSet
        {
            updateContent()
        }
    }
    
    //MARK: private
    
    private func updateContent()
    {
        guard
        
            let coredataModel:DVitaIdentifier = item?.coredataModel
        
        else
        {
            return
        }
        
        let content:[MSaveDataProtocol] = MSaveData.factoryContent(
            coredataModel:coredataModel)
        
        self.content = content
    }
}
