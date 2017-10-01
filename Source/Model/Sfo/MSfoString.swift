import Foundation

final class MSfoString
{
    //MARK: private
    
    private init() { }
    
    //MARK: internal
    
    class func stringFromBytes(
        start:Int,
        endNotIncluding:Int,
        data:Data) -> String?
    {
        let subdata:Data = data.subdata(
            start:start,
            endNotIncluding:endNotIncluding)
        
        let string:String? = stringToFirstNull(
            start:0,
            data:subdata)
        
        return string
    }
    
    class func stringToFirstNull(
        start:Int,
        data:Data) -> String?
    {
        let subdata:Data = data.subdata(
            start:start)
        let array:[UInt8] = Array(subdata)
        var validData:Data = Data()
        
        for item:UInt8 in array
        {
            guard
            
                item > 0
            
            else
            {
                break
            }
            
            validData.append(item)
        }
        
        guard
            
            let string:String = String(
                data:validData,
                encoding:String.Encoding.ascii)
            
        else
        {
            return nil
        }
        
        return string
    }
}
