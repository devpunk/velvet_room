import Foundation

extension DVitaItemDirectory
{
    //MARK: internal
    
    func config(itemDirectory:MVitaItemInDirectory)
    {
        super.config(item:itemDirectory)
        
        sfoTitle = itemDirectory.sfoTitle
        sfoSavedDataTitle = itemDirectory.sfoSavedDataTitle
        sfoSavedDataDetail = itemDirectory.sfoSavedDataDetail
        category = itemDirectory.category
        directoryType = Int32(itemDirectory.directoryType)
    }
}
