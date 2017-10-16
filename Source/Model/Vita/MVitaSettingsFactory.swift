import Foundation

extension MVitaSettings
{
    //MARK: private
    
    private static func factoryAccounts(
        xml:[String:Any]) -> [MVitaSettingsAccount]
    {
        var accounts:[MVitaSettingsAccount] = []
        
        guard
        
            let rawAccounts:[String:Any] = xml[
                kKeyAccounts] as? [String:Any],
            let rawDefault:[String:Any] = rawAccounts[
                kKeyAccountDefault] as? [String:Any],
            let accountDefault:MVitaSettingsAccount = factoryAccount(
                xml:rawDefault)
        
        else
        {
            return accounts
        }
        
        accounts.append(accountDefault)
        
        return accounts
    }
    
    private static func factoryAccount(
        xml:[String:Any]) -> MVitaSettingsAccount?
    {
        guard
        
            let accountId:String = xml[
                kKeyAccountId] as? String
        
        else
        {
            return nil
        }
        
        let account:MVitaSettingsAccount = MVitaSettingsAccount(
            accountId:accountId)
        
        return account
    }
    
    //MARK: internal
    
    static func factorySettings(xml:[String:Any]) -> MVitaSettings?
    {
        guard
        
            let rawSettings:[String:Any] = xml[
                kKeySettings] as? [String:Any]
        
        else
        {
            return nil
        }
        
        let accounts:[MVitaSettingsAccount] = factoryAccounts(
            xml:rawSettings)
        let settings:MVitaSettings = MVitaSettings(
            accounts:accounts)
        
        return settings
    }
}
