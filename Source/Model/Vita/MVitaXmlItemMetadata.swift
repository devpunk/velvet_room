import Foundation
import XmlHero

extension MVitaXmlItem
{
    //MARK: private
    
    private class func factoryMetadataModel(
        directories:[DVitaItemDirectory]) -> [String:Any]
    {
        var modelSaveData:[[String:Any]] = []
        
        for directory:DVitaItemDirectory in directories
        {
            let index:Int = modelSaveData.count + 1
            
            guard
            
                let saveDataItem:[String:Any] = factorySaveData(
                    directory:directory,
                    index:index)
            
            else
            {
                continue
            }
            
            modelSaveData.append(saveDataItem)
        }
        
        let model:[String:Any] = [
            MVitaXml.kKeyObjectMetadata:modelSaveData]
        
        return model
    }
    
    private class func factorySaveData(
        directory:DVitaItemDirectory,
        index:Int) -> [String:Any]?
    {
        guard
            
            let modelContent:[String:Any] = factoryContentModel(
                directory:directory,
                index:index)
            
        else
        {
            return nil
        }
        
        let modelSaveData:[String:Any] = [
            MVitaXml.kKeySaveData:modelContent]
        
        return modelSaveData
    }
    
    private class func factoryContentModel(
        directory:DVitaItemDirectory,
        index:Int) -> [String:Any]?
    {
        guard
            
            let saveDataTitle:String = directory.sfoSavedDataTitle,
            let title:String = directory.sfoTitle,
            let dirName:String = directory.identifier?.identifier,
            let detail:String = directory.sfoSavedDataDetail
        
        else
        {
            return nil
        }
        
        let dateModified:String = factoryDateModified(
            directory:directory)
        
        let model:[String:Any] = [
            MVitaXml.kKeySaveDataTitle:saveDataTitle,
            MVitaXml.kKeyDateModified:dateModified,
            MVitaXml.kKeySize:directory.size,
            MVitaXml.kKeyTitle:title,
            MVitaXml.kKeyDirName:dirName,
            MVitaXml.kKeyDetail:detail,
            MVitaXml.kKeyIndex:index]
        
        return model
    }
    
    private class func factoryDateModified(
        directory:DVitaItemDirectory) -> String
    {
        let dateModified:Date = Date(
            timeIntervalSince1970:directory.dateModified)
        let dateModifiedString:String = MVitaPtpDate.factoryString(
            date:dateModified)
        
        return dateModifiedString
    }
    
    //MARK: internal
    
    class func factoryXml(
        directories:[DVitaItemDirectory],
        completion:@escaping((Data?) -> ()))
    {
        let model:[String:Any] = factoryMetadataModel(
            directories:directories)
        
        Xml.data(object:model)
        { (data:Data?, error:XmlError?) in
            
            completion(data)
        }
    }
}
