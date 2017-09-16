import Foundation

extension MVitaConfiguration
{
    //MARK: internal
    
    static func factoryMap() -> [String:Any]?
    {
        guard
            
            let resourceUrl:URL = Bundle.main.url(
                forResource:kResourceName,
                withExtension:kResourceExtension)
            
        else
        {
            return nil
        }
        
        let data:Data
        
        do
        {
            try data = Data(
                contentsOf:resourceUrl,
                options:Data.ReadingOptions.mappedIfSafe)
        }
        catch
        {
            return nil
        }
        
        let propertyList:Any
        
        do
        {
            try propertyList = PropertyListSerialization.propertyList(
                from:data,
                options:PropertyListSerialization.ReadOptions(),
                format:nil)
        }
        catch
        {
            return nil
        }
        
        guard
            
            let map:[String:Any] = propertyList as? [String:Any]
            
        else
        {
            return nil
        }
        
        return map
    }
    
    static func removeDoubleScaping(string:String) -> String
    {
        let cleanedNewLine:String = string.replacingOccurrences(
            of:"\\n",
            with:"\n")
        let cleanedReturn:String = cleanedNewLine.replacingOccurrences(
            of:"\\r",
            with:"\r")
        let cleanedEnd:String = cleanedReturn.replacingOccurrences(
            of:"\\0",
            with:"\0")
        
        return cleanedEnd
    }
}
