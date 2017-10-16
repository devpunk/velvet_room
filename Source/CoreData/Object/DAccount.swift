import Foundation

extension DAccount
{
    //MARK: internal
    
    func createDeviceId()
    {
        guard
            
            deviceId == nil
        
        else
        {
            return
        }
        
        let uuid:String = UUID.init().uuidString
        deviceId = uuid
    }
}
