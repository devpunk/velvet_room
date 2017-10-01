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
        }
        
        return value
    }
}
