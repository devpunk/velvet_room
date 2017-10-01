import Foundation

extension MSfo
{
    //MARK: private
    
    private static func factoryText(
        format:MSfoItemFormat,
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
            format:format,
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
        let value:MSfoValueProtocol?
        
        switch item.format
        {
        case MSfoItemFormat.numeric:
            
            value = factoryNumeric(
                item:item,
                key:key,
                header:header,
                data:data)
            
            break
            
        default:
            
            value = factoryText(
                format:item.format,
                item:item,
                key:key,
                header:header,
                data:data)
            
            break
        }
        
        return value
    }
}
