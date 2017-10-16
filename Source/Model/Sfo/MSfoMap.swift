import Foundation

extension MSfo
{
    //MARK: private
    
    private static func factoryCategory(
        values:[MSfoKey:MSfoValueProtocol]) -> String
    {
        guard
        
            let category:MSfoValueText = values[
                MSfoKey.category] as? MSfoValueText
        
        else
        {
            return String()
        }
        
        return category.value
    }
    
    private static func factoryParentaLevel(
        values:[MSfoKey:MSfoValueProtocol]) -> Int
    {
        guard
            
            let parentalLevel:MSfoValueNumeric = values[
                MSfoKey.parentalLevel] as? MSfoValueNumeric
            
        else
        {
            return 0
        }
        
        return parentalLevel.value
    }
    
    private static func factoryTitle(
        values:[MSfoKey:MSfoValueProtocol]) -> String?
    {
        guard
            
            let title:MSfoValueText = values[
                MSfoKey.title] as? MSfoValueText
            
        else
        {
            return nil
        }
        
        return title.value
    }
    
    private static func factorySaveDataDetail(
        values:[MSfoKey:MSfoValueProtocol]) -> String?
    {
        guard
            
            let saveDataDetail:MSfoValueText = values[
                MSfoKey.saveDataDetail] as? MSfoValueText
            
        else
        {
            return nil
        }
        
        return saveDataDetail.value
    }
    
    private static func factorySaveDataDirectory(
        values:[MSfoKey:MSfoValueProtocol]) -> String?
    {
        guard
            
            let saveDataDirectory:MSfoValueText = values[
                MSfoKey.saveDataDirectory] as? MSfoValueText
            
        else
        {
            return nil
        }
        
        return saveDataDirectory.value
    }
    
    private static func factorySaveDataFileList(
        values:[MSfoKey:MSfoValueProtocol]) -> String?
    {
        guard
            
            let saveDataFileList:MSfoValueText = values[
                MSfoKey.saveDataFileList] as? MSfoValueText
            
        else
        {
            return nil
        }
        
        return saveDataFileList.value
    }
    
    private static func factorySaveDataParams(
        values:[MSfoKey:MSfoValueProtocol]) -> String?
    {
        guard
            
            let saveDataParams:MSfoValueText = values[
                MSfoKey.saveDataParams] as? MSfoValueText
            
        else
        {
            return nil
        }
        
        return saveDataParams.value
    }
    
    private static func factorySaveDataTitle(
        values:[MSfoKey:MSfoValueProtocol]) -> String?
    {
        guard
            
            let saveDataTitle:MSfoValueText = values[
                MSfoKey.saveDataTitle] as? MSfoValueText
            
        else
        {
            return nil
        }
        
        return saveDataTitle.value
    }
    
    //MARK: internal
    
    static func mapValues(
        values:[MSfoKey:MSfoValueProtocol]) -> MSfo
    {
        
        let category:String = factoryCategory(
            values:values)
        let parentalLevel:Int = factoryParentaLevel(
            values:values)
        let title:String? = factoryTitle(
            values:values)
        let saveDataDetail:String? = factorySaveDataDetail(
            values:values)
        let saveDataDirectory:String? = factorySaveDataDirectory(
            values:values)
        let saveDataFileList:String? = factorySaveDataFileList(
            values:values)
        let saveDataParams:String? = factorySaveDataParams(
            values:values)
        let saveDataTitle:String? = factorySaveDataTitle(
            values:values)
        
        let sfo:MSfo = MSfo(
            category:category,
            parentalLevel:parentalLevel,
            title:title,
            saveDataDetail:saveDataDetail,
            saveDataDirectory:saveDataDirectory,
            saveDataFileList:saveDataFileList,
            saveDataParams:saveDataParams,
            saveDataTitle:saveDataTitle)
        
        return sfo
    }
}
