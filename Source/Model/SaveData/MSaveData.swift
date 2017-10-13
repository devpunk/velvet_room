import Foundation

final class MSaveData:Model<ArchSaveData>
{
    weak var item:MHomeSaveDataItem?
    let content:[MSaveDataProtocol]
    
    required init()
    {
        content = MSaveData.factoryContent()
        
        super.init()
    }
}
