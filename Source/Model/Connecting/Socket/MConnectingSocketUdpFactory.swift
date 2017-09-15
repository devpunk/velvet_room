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
    
    //MARK: internal
    
    func factoryReplyData() -> Data?
    {
        return nil
    }
}
