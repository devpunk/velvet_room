import Foundation
import CocoaAsyncSocket

class MConnectConnected
{
    weak var connect:MConnect2?
    let deviceInfo:DeviceInfo
    
    init(deviceInfo:DeviceInfo, connect:MConnect2)
    {
        self.deviceInfo = deviceInfo
        self.connect = connect
    }
    
    func startConnection()
    {
        
    }
}
