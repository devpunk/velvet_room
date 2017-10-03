import Foundation

extension MVitaItemInDirectory
{
    //MARK: private
    
    private func findSfoData() -> Data?
    {
        for element:MVitaItemInElement in elements
        {
            guard
            
                element.fileExtension == MVitaItemInExtension.sfo
            
            else
            {
                continue
            }
            
            let data:Data? = element.data
            
            return data
        }
        
        return nil
    }
    
    //MARK: internal
    
    func parse()
    {
        mergeChildrenSize()
        
        guard
        
            let sfoData:Data = findSfoData(),
            let sfo:MSfo = MSfo.factorySfo(
                data:sfoData)
            
        else
        {
            return
        }
        
        sfoTitle = sfo.title
        sfoSavedDataTitle = sfo.saveDataTitle
        sfoSavedDataDetail = sfo.saveDataDetail
    }
}
