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
            let rawStorageSize:String = mapLocal[
                kKeyLocalStorageSize] as? String,
            let rawAvailableStorage:String = mapLocal[
                kKeyLocalAvailableStorage] as? String,
            let storageSize:UInt64 = UInt64(rawStorageSize),
            let availableStorage:UInt64 = UInt64(rawAvailableStorage)
            
        else
        {
            return nil
        }
        
        let local:MVitaConfigurationLocal = MVitaConfigurationLocal(
            storageSize:storageSize,
            availableStorage:availableStorage)
        
        return local
    }
}
