import Foundation

extension MSaveData
{
    //MARK: private
    
    private class func factoryRecords(
        coredataModel:DVitaIdentifier) -> [MSaveDataRecord]
    {
        guard
        
            let directories:[DVitaItemDirectory] = coredataModel.items?.array as? [
                DVitaItemDirectory]
        
        else
        {
            return []
        }
        
        let items:[MSaveDataRecord] = factoryRecords(
            directories:directories)
        
        return items
    }
    
    private class func factoryRecords(
        directories:[DVitaItemDirectory]) -> [MSaveDataRecord]
    {
        let dateFormatter:DateFormatter = MSaveDataRecord.factoryDateFormatter()
        let attributesTitle:[NSAttributedStringKey:Any] = MSaveDataRecord.factoryAttributesTitle()
        let attributesDescr:[NSAttributedStringKey:Any] = MSaveDataRecord.factoryAttributesDescr()
        let attributesDate:[NSAttributedStringKey:Any] = MSaveDataRecord.factoryAttributesDate()
        var items:[MSaveDataRecord] = []
        
        for directory:DVitaItemDirectory in directories
        {
            guard
                
                let item:MSaveDataRecord = MSaveDataRecord.factoryRecord(
                    coredataModel:directory,
                    dateFormatter:dateFormatter,
                    attributesTitle:attributesTitle,
                    attributesDescr:attributesDescr,
                    attributesDate:attributesDate)
            
            else
            {
                continue
            }
            
            items.append(item)
        }
        
        return items
    }
    
    //MARK: internal
    
    class func factoryContent(
        coredataModel:DVitaIdentifier) -> [MSaveDataProtocol]
    {
        var items:[MSaveDataProtocol] = []
        
        if let itemTitle:MSaveDataTitle = MSaveDataTitle(
            coredataModel:coredataModel)
        {
            items.append(itemTitle)
        }
        
        let records:[MSaveDataProtocol] = factoryRecords(
            coredataModel:coredataModel)
        items.append(contentsOf:records)
        
        return items
    }
}
