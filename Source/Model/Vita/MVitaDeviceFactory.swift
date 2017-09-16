import Foundation

extension MVitaDevice
{
    //MARK: private
    
    private static func parseDeviceId(
        strings:[String],
        model:MConnectingSocket) -> String?
    {
        let deviceIdTitle:String = model.configuration.device.deviceIdTitle
        
        for string:String in strings
        {
            guard
            
                string.contains(deviceIdTitle)
            
            else
            {
                continue
            }
            
            let stringComponents:[String] = string.components(
                separatedBy:deviceIdTitle)
            let deviceId:String? = stringComponents.last
            
            return deviceId
        }
        
        return nil
    }
    
    private static func parseDevicePort(
        strings:[String],
        model:MConnectingSocket) -> UInt16?
    {
        let devicePortTitle:String = model.configuration.device.devicePortTitle
        
        for string:String in strings
        {
            guard
            
                string.contains(devicePortTitle)
            
            else
            {
                continue
            }
            
            let stringComponents:[String] = string.components(
                separatedBy:devicePortTitle)
            
            guard
            
                let devicePortString:String = stringComponents.last
            
            else
            {
                return nil
            }
            
            let devicePort:UInt16? = UInt16(devicePortString)
            
            return devicePort
        }
        
        return nil
    }
    
    //MARK: internal
    
    static func factoryDevice(
        receivedString:String,
        socket:MConnectingSocketTcp) -> MVitaDevice?
    {
        
    }
    
    func parseDeviceInfo(string:String, host:String?) -> DeviceInfo?
    {
        let components:[String] = string.components(separatedBy: "\r\n")
        
        var deviceId:String?
        var devicePort:String?
        
        for component:String in components
        {
            if component.contains("device-id")
            {
                let components2:[String] = component.components(separatedBy: "device-id:")
                
                if components2.count > 1
                {
                    deviceId = components2[1]
                }
            }
            else if component.contains("device-port")
            {
                let components2:[String] = component.components(separatedBy: "device-port:")
                
                if components2.count > 1
                {
                    devicePort = components2[1]
                }
            }
        }
        
        guard
            
            let foundId:String = deviceId,
            let foundPort:String = devicePort,
            let foundIp:String = host
            
            else
        {
            return nil
        }
        
        let deviceInfo:DeviceInfo = DeviceInfo(
            deviceId:foundId,
            deviceIp:foundIp,
            dataPort:foundPort)
        
        return deviceInfo
    }
}
