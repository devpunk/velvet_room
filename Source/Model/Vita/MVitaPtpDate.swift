import Foundation

final class MVitaPtpDate
{
    private static let kDateFormat:String = "yyyyMMdd'T'HH:mm:ss.SSS"
    
    //MARK: private
    
    private init() { }
    
    private class func factoryDateFormatter() -> DateFormatter
    {
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = kDateFormat
        
        return dateFormatter
    }
    
    private class func factoryDate(string:String) -> Date?
    {
        let dateFormatter:DateFormatter = factoryDateFormatter()
        let date:Date? = dateFormatter.date(from:string)
        
        return date
    }
    
    //MARK: internal
    
    class func factoryDate(data:Data) -> Date?
    {
        guard
        
            let string:String = MVitaPtpString.factoryString(
                data:data)
        
        else
        {
            return nil
        }
        
        let date:Date? = factoryDate(string:string)
        
        return date
    }
}
