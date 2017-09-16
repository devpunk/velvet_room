import Foundation

extension MVitaConfiguration
{
    //MARK: private
    
    
    
    private static func factoryConfigurationBroadcast(
        map:[String:Any]) -> MVitaConfigurationBroadcast?
    {
        guard
            
            let mapBroadcast:[String:Any] = map[
                kKeyBroadcast] as? [String:Any],
            let searchCommand:String = mapBroadcast[
                kKeyBroadcastSearchCommand] as? String,
            let searchProtocol:String = mapBroadcast[
                kKeyBroadcastSearchProtocol] as? String,
            let replyAvailable:String = mapBroadcast[
                kKeyBroadcastReplyAvailable] as? String,
            let replyOk:String = mapBroadcast[
                kKeyBroadcastReplyOk] as? String,
            let replyPinError:String = mapBroadcast[
                kKeyBroadcastReplyPinError] as? String,
            let replyConnected:String = mapBroadcast[
                kKeyBroadcastReplyConnected] as? String,
            let replyConnectingError:String = mapBroadcast[
                kKeyBroadcastReplyConnectingError] as? String,
            let pinTitle:String = mapBroadcast[
                kKeyBroadcastPinTitle] as? String
        
        else
        {
            return nil
        }
        
        let cleanedReplyAvailable:String = removeDoubleScaping(
            string:replyAvailable)
        
        let broadcast:MVitaConfigurationBroadcast = MVitaConfigurationBroadcast(
            searchCommand:searchCommand,
            searchProtocol:searchProtocol,
            replyAvailable:cleanedReplyAvailable,
            replyOk:replyOk,
            replyPinError:replyPinError,
            replyConnected:replyConnected,
            replyConnectingError:replyConnectingError,
            pinTitle:pinTitle)
        
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
        
        let cleanedLineSeparator:String = removeDoubleScaping(
            string:lineSeparator)
        
        let configuration:MVitaConfiguration = MVitaConfiguration(
            broadcast:broadcast,
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
