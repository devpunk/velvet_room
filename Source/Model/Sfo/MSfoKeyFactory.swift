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
        let subdata:Data = data.subdata(start:byteStart)
        
        guard
        
            let string:String = MSfoString.stringToFirstNull(
                data:subdata)
        
        else
        {
            return nil
        }
        
        let key:MSfoKey? = MSfoKey(rawValue:string)
        
        return key
    }
}
