import Foundation

extension MVitaConfiguration
{
    //MARK: private
    
    private static func factoryConfiguration(
        map:[String:Any]) -> MVitaConfiguration?
    {
        guard
        
            let broadcast:MVitaConfigurationBroadcast = factoryConfigurationBroadcast(
                map:map),
            let device:MVitaConfigurationDevice = factoryConfigurationDevice(
                map:map),
            let local:MVitaConfigurationLocal = factoryConfigurationLocal(
                map:map),
            let lineSeparator:String = map[kKeyLineSeparator] as? String,
            let port:UInt16 = map[kKeyPort] as? UInt16
        
        else
        {
            return nil
        }
        
        let cleanedLineSeparator:String = removeDoubleScaping(
            string:lineSeparator)
        
        let configuration:MVitaConfiguration = MVitaConfiguration(
            broadcast:broadcast,
            device:device,
            local:local,
            lineSeparator:cleanedLineSeparator,
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
