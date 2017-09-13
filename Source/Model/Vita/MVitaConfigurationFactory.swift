import Foundation

extension MVitaConfiguration
{
    private static let kResourceName:String = "vitaConnection"
    private static let kResourceExtension:String = "plist"
    private static let kKeyPort:String = "port"
    
    //MARK: private
    
    private static func factoryMap() -> [String:Any]?
    {
        guard
        
            let resourceUrl:URL = Bundle.main.url(
                forResource:kResourceName,
                withExtension:kResourceExtension),
            let dictionary:NSDictionary = NSDictionary(
                contentsOf:resourceUrl),
            let map:[String:Any] = dictionary as? [String:Any]
        
        else
        {
            return nil
        }
        
        return map
    }
    
    private static func factoryConfiguration(
        map:[String:Any]) -> MVitaConfiguration?
    {
        guard
        
            let port:UInt16 = map[kKeyPort] as? UInt16
        
        else
        {
            return nil
        }
        
        let configuration:MVitaConfiguration = MVitaConfiguration(
            port:port)
        
        return configuration
    }
    
    //MARK: internal
    
    static func factoryConfiguration() -> MVitaConfiguration?
    {
        guard
        
            let map:[String:Any] = factoryMap(),
            let configuration:MVitaConfiguration = factoryConfiguration(
                map:map)
        
        else
        {
            return nil
        }
        
        return configuration
    }
}
