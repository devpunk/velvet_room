import Foundation

extension MSfo
{
    private typealias Router = (
        (MSfoItem,
        MSfoKey,
        MSfoHeader,
        Data) -> (MSfoValueProtocol?))
    
    private static let kRouterMap:[MSfoItemFormat:Router] = [
        MSfoItemFormat.numeric:factoryNumeric]
    
    //MARK: private

    private static func routerForFormat(
        format:MSfoItemFormat) -> Router
    {
        guard
        
            let router:Router = kRouterMap[format]
        
        else
        {
            return factoryText
        }
        
        return router
    }
    
    private static func factoryText(
        item:MSfoItem,
        key:MSfoKey,
        header:MSfoHeader,
        data:Data) -> MSfoValueText?
    {
        let byteStart:Int = item.valueOffset + header.valuesOffset
        let byteEnd:Int = byteStart + item.valueLength
        
        guard
        
            let string:String = MSfoString.stringFromBytes(
                start:byteStart,
                endNotIncluding:byteEnd,
                data:data)
        
        else
        {
            return nil
        }
        
        let value:MSfoValueText = MSfoValueText(
            format:item.format,
            key:key,
            value:string)
        
        return value
    }
    
    private static func factoryNumeric(
        item:MSfoItem,
        key:MSfoKey,
        header:MSfoHeader,
        data:Data) -> MSfoValueNumeric?
    {
        let byteStart:Int = item.valueOffset + header.valuesOffset
        let byteEnd:Int = byteStart + item.valueLength
        
        guard
            
            let int:Int = MSfoInt.intFromBytes(
                start:byteStart,
                endNotIncluding:byteEnd,
                data:data)
            
        else
        {
            return nil
        }
        
        let value:MSfoValueNumeric = MSfoValueNumeric(
            key:key,
            value:int)
        
        return value
    }
    
    //MARK: internal
    
    static func factoryValue(
        item:MSfoItem,
        key:MSfoKey,
        header:MSfoHeader,
        data:Data) -> MSfoValueProtocol?
    {
        let router:Router = routerForFormat(
            format:item.format)
        
        let value:MSfoValueProtocol? = router(
            item,
            key,
            header,
            data)
        
        return value
    }
}
