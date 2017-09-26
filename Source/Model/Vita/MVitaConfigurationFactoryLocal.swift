import Foundation

extension MVitaConfiguration
{
    //MARK: internal
    
    static func factoryConfigurationLocal(
        map:[String:Any]) -> MVitaConfigurationLocal?
    {
        guard
            
            let mapLocal:[String:Any] = map[
                kKeyLocal] as? [String:Any],
            let rawAvailableStorage:String = mapLocal[
                kKeyLocalAvailableStorage] as? String,
            let availableStorage:Int = Int(rawAvailableStorage)
            
        else
        {
            return nil
        }
        
        let local:MVitaConfigurationLocal = MVitaConfigurationLocal(
            availableStorage:availableStorage)
        
        return local
    }
}
