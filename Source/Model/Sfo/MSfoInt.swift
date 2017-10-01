import Foundation

final class MSfoInt
{
    //MARK: private
    
    private init() { }
    
    //MARK: internal
    
    class func intFromBytes(
        start:Int,
        endNotIncluding:Int,
        data:Data) -> Int?
    {
        let subdata:Data = data.subdata(
            start:start,
            endNotIncluding:endNotIncluding)
        
        guard
        
            let uInt32:UInt32 = subdata.valueFromBytes()
        
        else
        {
            return nil
        }
        
        let int:Int = Int(uInt32)
        
        return int
    }
}
