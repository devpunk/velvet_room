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
        let dateFormatter:DateFormatter = MHomeSaveDataItem.factoryDateFormatter()
        var items:[MHomeSaveDataItem] = []
        
        for identifier:DVitaIdentifier in identifiers
        {
            guard
            
                let item:MHomeSaveDataItem = MHomeSaveDataItem.factoryItem(
                    identifier:identifier,
                    dateFormatter:dateFormatter)
            
            else
            {
                continue
            }
            
            items.append(item)
        }
        
        self.saveDataItems = items
        view?.refresh()
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
