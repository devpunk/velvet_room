import Foundation
import XmlHero

extension MVitaXmlItem
{
    /*
 
     <?xml version="1.0" encoding="UTF-8" ?>
     <objectMetadata>
     <saveData savedataTitle="display name" dateTimeUpdated="2017-08-31T06:35:31+00:00" size="152220" title="sometitle" dirName="somedirname" ohfi="1" detail="asd" />
     </objectMetadata>
 
 */
    
    //MARK: private
    
    private class func factoryMetadataModel(
        directory:DVitaItemDirectory) -> [String:Any]?
    {
        guard
            
            let modelContent:[String:Any] = factoryContentModel(
                directory:directory)
        
        else
        {
            return nil
        }
        
        let modelSaveData:[String:Any] = [
            MVitaXml.kKeySaveData:modelContent]
        let model:[String:Any] = [
            MVitaXml.kKeyObjectMetadata:modelSaveData]
        
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
    
    private class func factoryContentModel(
        directory:DVitaItemDirectory) -> [String:Any]?
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
            MVitaXml.kKeyDetail:detail]
        
        return model
    }
    
    //MARK: internal
    
    class func factoryXml(
        directory:DVitaItemDirectory,
        completion:@escaping((Data?) -> ()))
    {
        guard
            
            let model:[String:Any] = factoryMetadataModel(
                directory:directory)
        
        else
        {
            completion(nil)
            
            return
        }
        
        Xml.data(object:model)
        { (data:Data?, error:XmlError?) in
            
            completion(data)
        }
    }
}
