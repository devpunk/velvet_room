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
            let storageSize:UInt64 = mapLocal[
                kKeyLocalStorageSize] as? UInt64,
            let availableStorage:UInt64 = mapLocal[
                kKeyLocalAvailableStorage] as? UInt64
            
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
