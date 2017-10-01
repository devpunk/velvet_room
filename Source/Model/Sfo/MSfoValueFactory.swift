import Foundation

extension MSfo
{
    //MARK: private
    
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
            key:key,
            value:string)
        
        return value
    }
    
    private static func factoryCharacters(
        item:MSfoItem,
        key:MSfoKey,
        header:MSfoHeader,
        data:Data) -> MSfoValueCharacters?
    {
        let byteStart:Int = item.valueOffset + header.valuesOffset
        let byteEnd:Int = byteStart + item.valueLength
        
        guard
            
            let characters:String = MSfoString.stringFromBytes(
                start:byteStart,
                endNotIncluding:byteEnd,
                data:data)
            
        else
        {
            return nil
        }
        
        let value:MSfoValueCharacters = MSfoValueCharacters(
            key:key,
            value:characters)
        
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
        case MSfoItemFormat.text:
            
            value = factoryText(
                item:item,
                key:key,
                header:header,
                data:data)
            
            break
            
        case MSfoItemFormat.characters:
            
            value = factoryCharacters(
                item:item,
                key:key,
                header:header,
                data:data)
            
            break
            
        case MSfoItemFormat.numeric:
            
            value = factoryNumeric(
                item:item,
                key:key,
                header:header,
                data:data)
            
            break
        }
        
        return value
    }
}
