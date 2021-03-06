import Foundation

extension MSfo
{
    //MARK: internal
    
    static func factoryKey(
        item:MSfoItem,
        header:MSfoHeader,
        data:Data) -> MSfoKey?
    {
        let byteStart:Int = item.keyOffset + header.keysOffset
        
        guard
        
            let string:String = MSfoString.stringToFirstNull(
                start:byteStart,
                data:data)
        
        else
        {
            return nil
        }
        
        let lowerCase:String = string.lowercased()
        let key:MSfoKey? = MSfoKey(
            rawValue:lowerCase)
        
        return key
    }
}
