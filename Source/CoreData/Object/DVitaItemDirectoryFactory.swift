import Foundation

extension DVitaItemDirectory
{
    //MARK: internal
    
    func config(itemDirectory:MVitaItemInDirectory)
    {
        super.config(item:itemDirectory)
        
        sfoTitle = itemDirectory.sfoTitle
        sfoDetail = itemDirectory.sfoDetail
        category = itemDirectory.category
        directoryType = Int32(itemDirectory.directoryType)
    }
}
