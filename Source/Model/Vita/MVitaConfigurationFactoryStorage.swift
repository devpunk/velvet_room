import Foundation

extension MVitaConfiguration
{
    //MARK: internal
    
    static func factoryConfigurationStorage(
        map:[String:Any]) -> MVitaConfigurationStorage?
    {
        guard
            
            let mapStorage:[String:Any] = map[
                kKeyStorage] as? [String:Any],
            let storageId:UInt32 = mapStorage[
                kKeyStorageId] as? UInt32,
            let protectionStatus:UInt16 = mapStorage[
                kKeyStorageProtectionStatus] as? UInt16
            
        else
        {
            return nil
        }
        
        let storage:MVitaConfigurationStorage = MVitaConfigurationStorage(
            storageId:storageId,
            protectionStatus:protectionStatus)
        
        return storage
    }
}
