import Foundation

extension MHome
{
    //MARK: private
    
    private func loadSaveData(
        database:Database)
    {
        
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
