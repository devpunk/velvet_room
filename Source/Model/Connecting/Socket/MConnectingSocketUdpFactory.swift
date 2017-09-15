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
    {
        let hostName:String = String.localizedModel(
            key:"MConnectingSocketUdp_hostName")
        let port:String = "\(configuration.port)"
        let string:String = String(
            format:configuration.broadcast.replyAvailable,
            deviceId,
            hostName,
            port)
        
        return string
    }
    
    //MARK: internal
    
    func factoryReplyAvailable()
    {
        fetchDeviceId
        { [weak self] (deviceId:String) in
            
            guard
            
                let string:String = self?.responseString(
                    deviceId:deviceId),
                let data:Data = string.data(
                    using:String.Encoding.utf8,
                    allowLossyConversion:false)
            
            else
            {
                return
            }
            
            self?.replyAvaiable = data
        }
    }
}
