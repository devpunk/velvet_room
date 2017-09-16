import Foundation

extension MVitaConfiguration
{
    private static let kResourceName:String = "vitaConnection"
    private static let kResourceExtension:String = "plist"
    private static let kKeyBroadcast:String = "broadcast"
    private static let kKeyBroadcastSearchCommand:String = "searchCommand"
    private static let kKeyBroadcastSearchProtocol:String = "searchProtocol"
    private static let kKeyBroadcastReplyAvailable:String = "replyAvailable"
    private static let kKeyBroadcastReplyOk:String = "replyOk"
    private static let kKeyBroadcastReplyPinError:String = "replyPinError"
    private static let kKeyBroadcastReplyConnected:String = "replyConnected"
    private static let kKeyBroadcastReplyConnectingError:String = "replyConnectingError"
    private static let kKeyBroadcastPinTitle:String = "pinTitle"
    private static let kKeyLineSeparator:String = "lineSeparator"
    private static let kKeyPort:String = "port"
    
    //MARK: private
    
    private static func factoryMap() -> [String:Any]?
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
    
    private static func removeDoubleScaping(string:String) -> String
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
