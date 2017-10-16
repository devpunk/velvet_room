import Foundation

final class MHome:Model<ArchHome>
{
    var database:Database?
    var account:DAccount?
    var saveDataItems:[MHomeSaveDataItem]
    
    required init()
    {
        saveDataItems = []
        
        super.init()
    }
}
