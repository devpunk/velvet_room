import Foundation

final class MSfoString
{
    //MARK: private
    
    private init() { }
    
    //MARK: internal
    
    class func stringToFirstNull(data:Data) -> String?
    {
        let array:[UInt8] = Array(data)
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
