import Foundation

extension MHome
{
    //MARK: private
    
    private func asyncLoadSession()
    {
        guard
        
            let database:Database = Database(bundle:nil)
        
        else
        {
            return
        }
        
        self.database = database
        
        database.fetch
        { [weak self] (accountList:[DAccount]) in
            
            guard
            
                let account:DAccount = accountList.first
            
            else
            {
                self?.createAccount()
                
                return
            }
            
            self?.accountLoaded(account:account)
        }
    }
    
    private func createAccount()
    {
        database?.create
        { [weak self] (account:DAccount) in
            
            account.createDeviceId()
            
            self?.database?.save
            { [weak self] in
                
                self?.accountLoaded(account:account)
            }
        }
    }
    
    private func accountLoaded(account:DAccount)
    {
        self.account = account
        
        DispatchQueue.main.async
        { [weak self] in
            
            guard
            
                let controller:CHome = self?.view?.controller as? CHome
            
            else
            {
                return
            }
            
            controller.sessionLoaded()
        }
    }
    
    //MARK: internal
    
    func loadSession()
    {
        DispatchQueue.global(
            qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncLoadSession()
        }
    }
}
