import Foundation

extension MVitaConfiguration
{
    private static let kResourceName:String = "vitaConnection"
    private static let kResourceExtension:String = "plist"
    private static let kKeyBroadcast:String = "broadcast"
    private static let kKeyBroadcastSearchCommand:String = "searchCommand"
    private static let kKeyBroadcastSearchProtocol:String = "searchProtocol"
    private static let kKeyLineSeparator:String = "lineSeparator"
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
    
    private static func factoryConfigurationBroadcast(
        map:[String:Any]) -> MVitaConfigurationBroadcast?
    {
        guard
            
            let mapBroadcast:[String:Any] = map[
                kKeyBroadcast] as? [String:Any],
            let searchCommand:String = mapBroadcast[
                kKeyBroadcastSearchCommand] as? String,
            let searchProtocol:String = mapBroadcast[
                kKeyBroadcastSearchProtocol] as? String
        
        else
        {
            return nil
        }
        
        let broadcast:MVitaConfigurationBroadcast = MVitaConfigurationBroadcast(
            searchCommand:searchCommand,
            searchProtocol:searchProtocol)
        
        return broadcast
    }
    
    private static func factoryConfiguration(
        map:[String:Any]) -> MVitaConfiguration?
    {
        guard
        
            let broadcast:MVitaConfigurationBroadcast = factoryConfigurationBroadcast(
                map:map),
            let lineSeparator:String = map[kKeyLineSeparator] as? String,
            let port:UInt16 = map[kKeyPort] as? UInt16
        
        else
        {
            return nil
        }
        
        let configuration:MVitaConfiguration = MVitaConfiguration(
            broadcast:broadcast,
            lineSeparator:lineSeparator,
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
