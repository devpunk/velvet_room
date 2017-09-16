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
        guard
            
            let model:MConnectingSocket = socket.model
            
        else
        {
            return nil
        }
        
        let strings:[String] = receivedString.components(
            separatedBy:model.configuration.lineSeparator)
        
        guard
        
            let ipAddress:String = socket.socket.connectedHost,
            let deviceId:String = parseDeviceId(
                strings:strings,
                model:model),
            let devicePort:UInt16 = parseDevicePort(
                strings:strings,
                model:model)
        
        else
        {
            return nil
        }
        
        let device:MVitaDevice = MVitaDevice(
            ipAddress:ipAddress,
            identifier:deviceId,
            port:devicePort)
        
        return device
    }
}
