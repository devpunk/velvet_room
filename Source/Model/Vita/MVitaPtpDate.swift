import Foundation

final class MVitaPtpDate
{
    private static let kDateFormat:String = "yyyyMMdd'T'HHmmss"
    private static let kComponentSeparator:String = "."
    private static let kMilliSeconds:String = "0"
    
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
        let stringComponents:[String] = string.components(
            separatedBy:kComponentSeparator)
        
        guard
            
            let firstComponent:String = stringComponents.first
        
        else
        {
            return nil
        }
        
        let dateFormatter:DateFormatter = factoryDateFormatter()
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
        let dateFormatter:DateFormatter = factoryDateFormatter()
        var string:String = dateFormatter.string(
            from:date)
        string.append(kComponentSeparator)
        string.append(kMilliSeconds)
        
        return string
    }
}
