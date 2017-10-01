import Foundation

extension MSfo
{
    //MARK: private
    
    private static func factoryItems(
        count:Int,
        data:Data) -> [MSfoItem]
    {
        var items:[MSfoItem] = []
        var subdata:Data = data.subdata(
            start:MSfoHeader.kBytes)
        
        for _:Int in 0 ..< count
        {
            guard
                
                let item:MSfoItem = MSfoItem.factoryItem(
                    data:subdata)
            
            else
            {
                continue
            }
            
            items.append(item)
            subdata = subdata.subdata(
                start:MSfoItem.kBytes)
        }
        
        return items
    }
    
    private static func factorySfo(
        header:MSfoHeader,
        items:[MSfoItem],
        data:Data) -> MSfo
    {
        var values:[MSfoKey:MSfoValueProtocol] = [:]
        
        for item:MSfoItem in items
        {
            guard
            
                let key:MSfoKey = MSfo.factoryKey(
                    item:item,
                    header:header,
                    data:data),
                let value:MSfoValueProtocol = MSfo.factoryValue(
                    item:item,
                    key:key,
                    header:header,
                    data:data)
            
            else
            {
                continue
            }
            
            values[key] = value
        }
        
        let sfo:MSfo = mapValues(values:values)
        
        return sfo
    }
    
    //MARK: internal
    
    static func factorySfo(data:Data) -> MSfo?
    {
        guard
        
            let header:MSfoHeader = MSfoHeader.factoryHeader(
                data:data)
        
        else
        {
            return nil
        }
        
        let items:[MSfoItem] = factoryItems(
            count:header.count,
            data:data)
        let sfo:MSfo = factorySfo(
            header:header,
            items:items,
            data:data)
        
        return sfo
    }
}
