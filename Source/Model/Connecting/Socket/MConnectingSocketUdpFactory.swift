import Foundation

extension MConnectingSocketUdp
{
    //MARK: private
    
    private func fetchDeviceId(completion:@escaping((String) -> ()))
    {
        guard
        
            let database:Database = Database(bundle:nil)
        
        else
        {
            return
        }
        
        database.fetch
        { (accountList:[DAccount]) in
            
            guard
            
                let account:DAccount = accountList.first,
                let deviceId:String = account.deviceId
            
            else
            {
                return
            }
            
            completion(deviceId)
        }
    }
    
    private func responseString(deviceId:String) -> String
    {/*
        let string:String = String(
            format:configuration.broadcast.replyAvailable,
            deviceId)*/
        
        return configuration.broadcast.replyAvailable
    }
    
    //MARK: internal
    
    func factoryReplyAvailable()
    {
        fetchDeviceId
        { [weak self] (deviceId:String) in
            
            guard
            
                let string:String = self?.responseString(
                    deviceId:deviceId)
            
            else
            {
                return
            }
            
            debugPrint(string)
        }
    }
}
