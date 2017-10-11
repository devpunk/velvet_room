import Foundation

final class CSaveData:Controller<ArchSaveData>
{
    init(item:MHomeSaveDataItem)
    {
        super.init()
        model.item = item
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
