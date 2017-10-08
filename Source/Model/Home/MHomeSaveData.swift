import Foundation

extension MHome
{
    //MARK: private
    
    private func loadSaveData(
        database:Database)
    {
        database.fetch
        { [weak self] (identifiers:[DVitaIdentifier]) in
            
            self?.identifiersFetched(identifiers:identifiers)
        }
    }
    
    private func identifiersFetched(
        identifiers:[DVitaIdentifier])
    {
        var items:[MHomeSaveDataItem] = []
        
        for identifier:DVitaIdentifier in identifiers
        {
            
        }
        
        self.saveDataItems = items
    }
    
    //MARK: internal
    
    func loadSaveData()
    {
        guard
        
            let database:Database = self.database
        
        else
        {
            return
        }
        
        DispatchQueue.global(
            qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.loadSaveData(database:database)
        }
    }
}
