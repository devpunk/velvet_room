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
    }
}
