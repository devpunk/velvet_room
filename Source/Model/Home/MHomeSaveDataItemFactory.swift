import Foundation

extension MHomeSaveDataItem
{
    //MARK: private
    
    private class func factoryGameName(
        identifier:DVitaIdentifier) -> String?
    {
        guard
        
            let directories:[DVitaItemDirectory] = identifier.items?.array as? [
                DVitaItemDirectory],
            let gameName:String = directories.last?.sfoTitle
        
        else
        {
            return nil
        }
        
        return gameName
    }
    
    //MARK: internal
    
    class func factoryItem(
        identifier:DVitaIdentifier) -> MHomeSaveDataItem?
    {
        guard
        
            let gameName:String = factoryGameName(
                identifier:identifier)
        
        else
        {
            return nil
        }
    }
}
