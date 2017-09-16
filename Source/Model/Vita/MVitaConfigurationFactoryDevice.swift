import Foundation

extension MVitaConfiguration
{
    //MARK: internal
    
    static func factoryConfigurationDevice(
        map:[String:Any]) -> MVitaConfigurationDevice?
    {
        guard
            
            let mapDevice:[String:Any] = map[
                kKeyDevice] as? [String:Any],
            let deviceIdTitle:String = mapDevice[
                kKeyDeviceDeviceIdTitle] as? String,
            let devicePortTitle:String = mapDevice[
                kKeyDeviceDevicePortTitle] as? String
            
        else
        {
            return nil
        }
        
        let device:MVitaConfigurationDevice = MVitaConfigurationDevice(
            deviceIdTitle:deviceIdTitle,
            devicePortTitle:devicePortTitle)
        
        return device
    }
}
