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
    
    private class func factoryLastUpdate(
        identifier:DVitaIdentifier,
        dateFormatter:DateFormatter) -> String?
    {
        guard
            
            let directories:[DVitaItemDirectory] = identifier.items?.array as? [
                DVitaItemDirectory],
            let lastUpdate:TimeInterval = directories.last?.dateModified
            
        else
        {
            return nil
        }
        
        let date:Date = Date(timeIntervalSince1970:lastUpdate)
        let dateString:String = dateFormatter.string(from:date)
        
        return dateString
    }
    
    //MARK: internal
    
    class func factoryDateFormatter() -> DateFormatter
    {
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.short
        
        return dateFormatter
    }
    
    class func factoryItem(
        identifier:DVitaIdentifier,
        dateFormatter:DateFormatter) -> MHomeSaveDataItem?
    {
        guard
        
            let gameName:String = factoryGameName(
                identifier:identifier),
            let lastUpdate:String = factoryLastUpdate(
                identifier:identifier,
                dateFormatter:dateFormatter)
        
        else
        {
            return nil
        }
        
        let item:MHomeSaveDataItem = MHomeSaveDataItem(
            coredataModel:identifier,
            gameName:gameName,
            lastUpdated:lastUpdate,
            thumbnail:)
    }
}
