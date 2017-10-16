import Foundation

final class MVitaPtpDate
{
    private static let kInDateFormat:String = "yyyyMMdd'T'HHmmss"
    private static let kOutDateFormat:String = "yyyy-MM-dd'T'HH:mm:ss+00:00"
    private static let kComponentSeparator:String = "."
    
    //MARK: private
    
    private init() { }
    
    private class func factoryInDateFormatter() -> DateFormatter
    {
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = kInDateFormat
        
        return dateFormatter
    }
    
    private class func factoryOutDateFormatter() -> DateFormatter
    {
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = kOutDateFormat
        
        return dateFormatter
    }
    
    private class func factoryDate(string:String) -> Date?
    {
        let stringComponents:[String] = string.components(
            separatedBy:kComponentSeparator)
        
        guard
            
            let firstComponent:String = stringComponents.first
        
        else
        {
            return nil
        }
        
        let dateFormatter:DateFormatter = factoryInDateFormatter()
        let date:Date? = dateFormatter.date(
            from:firstComponent)
        
        return date
    }
    
    //MARK: internal
    
    class func factoryDate(
        data:Data) -> Date?
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
    
    class func factoryString(
        date:Date) -> String
    {
        let dateFormatter:DateFormatter = factoryOutDateFormatter()
        let string:String = dateFormatter.string(
            from:date)
        
        return string
    }
}
