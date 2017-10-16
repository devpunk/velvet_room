import Foundation

extension MVitaConfiguration
{
    //MARK: internal
    
    static func factoryConfigurationBroadcast(
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
                kKeyBroadcastPinTitle] as? String,
            let methodSeparator:String = mapBroadcast[
                kKeyBroadcastMethodSeparator] as? String
            
        else
        {
            return nil
        }
        
        let cleanedReplyAvailable:String = removeDoubleScaping(
            string:replyAvailable)
        let cleanedReplyOk:String = removeDoubleScaping(
            string:replyOk)
        let cleanedReplyPinError:String = removeDoubleScaping(
            string:replyPinError)
        let cleanedReplyConnected:String = removeDoubleScaping(
            string:replyConnected)
        let cleanedReplyConnectingError:String = removeDoubleScaping(
            string:replyConnectingError)
        
        let broadcast:MVitaConfigurationBroadcast = MVitaConfigurationBroadcast(
            searchCommand:searchCommand,
            searchProtocol:searchProtocol,
            replyAvailable:cleanedReplyAvailable,
            replyOk:cleanedReplyOk,
            replyPinError:cleanedReplyPinError,
            replyConnected:cleanedReplyConnected,
            replyConnectingError:cleanedReplyConnectingError,
            pinTitle:pinTitle,
            methodSeparator:methodSeparator)
        
        return broadcast
    }
}
