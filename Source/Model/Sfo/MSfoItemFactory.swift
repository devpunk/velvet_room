import Foundation

extension MSfoItem
{
    static let kBytes:Int = 16
    private static let kFormatOffset:Int = 2
    private static let kValueLengthOffset:Int = 4
    private static let kValueMaxLengthOffset:Int = 8
    private static let kValueOffsetOffset:Int = 12
    
    //MARK: private
    
    private static func factoryKeyOffset(
        data:Data) -> Int?
    {
        guard
            
            let rawKeyOffset:UInt16 = data.valueFromBytes()
            
        else
        {
            return nil
        }
        
        let keyOffset:Int = Int(rawKeyOffset)
        
        return keyOffset
    }
    
    private static func factoryFormat(
        data:Data) -> MSfoItemFormat?
    {
        let subdata:Data = data.subdata(
            start:kFormatOffset)
        
        guard
            
            let rawFormat:UInt16 = subdata.valueFromBytes()
            
        else
        {
            return nil
        }
        
        let intFormat:Int = Int(rawFormat)
        let format:MSfoItemFormat = MSfoItemFormat.text
        
        return format
    }
    
    private static func factoryValueLength(
        data:Data) -> Int?
    {
        let subdata:Data = data.subdata(
            start:kValueLengthOffset)
        
        guard
            
            let rawValueLength:UInt32 = subdata.valueFromBytes()
            
        else
        {
            return nil
        }
        
        let valueLength:Int = Int(rawValueLength)
        
        return valueLength
    }
    
    private static func factoryValueMaxLength(
        data:Data) -> Int?
    {
        let subdata:Data = data.subdata(
            start:kValueMaxLengthOffset)
        
        guard
            
            let rawValueMaxLength:UInt32 = subdata.valueFromBytes()
            
        else
        {
            return nil
        }
        
        let valueMaxLength:Int = Int(rawValueMaxLength)
        
        return valueMaxLength
    }
    
    private static func factoryValueOffset(
        data:Data) -> Int?
    {
        let subdata:Data = data.subdata(
            start:kValueOffsetOffset)
        
        guard
            
            let rawValueOffset:UInt32 = subdata.valueFromBytes()
            
        else
        {
            return nil
        }
        
        let valueOffset:Int = Int(rawValueOffset)
        
        return valueOffset
    }
    
    //MARK: internal
    
    static func factoryItem(
        data:Data) -> MSfoItem?
    {
        guard
            
            let format:MSfoItemFormat = factoryFormat(
                data:data),
            let keyOffset:Int = factoryKeyOffset(
                data:data),
            let valueLength:Int = factoryValueLength(
                data:data),
            let valueMaxLength:Int = factoryValueMaxLength(
                data:data),
            let valueOffset:Int = factoryValueOffset(
                data:data)
        
        else
        {
            return nil
        }
        
        let item:MSfoItem = MSfoItem(
            format:format,
            keyOffset:keyOffset,
            valueLength:valueLength,
            valueMaxLength:valueMaxLength,
            valueOffset:valueOffset)
        
        return item
    }
}
