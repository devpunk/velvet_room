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
        item:DVitaIdentifier,
        directory:DVitaItemDirectory) -> [String:Any]
    {
        let modelContent:[String:Any] = factoryContentModel(
            item:item,
            directory:directory)
        let modelSaveData:[String:Any] = [
            MVitaXml.kKeySaveData:modelContent]
        let model:[String:Any] = [
            MVitaXml.kKeyObjectMetadata:modelSaveData]
        
        return model
    }
    
    private class func factoryContentModel(
        item:DVitaIdentifier,
        directory:DVitaItemDirectory) -> [String:Any]
    {
        let model:[String:Any] = [
            MVitaXml.kKeySaveDataTitle:]
        
        return model
    }
    
    //MARK: internal
    
    class func factoryXml(
        item:DVitaIdentifier,
        directory:DVitaItemDirectory,
        completion:@escaping((Data?) -> ()))
    {
        let model:[String:Any] = factoryMetadataModel(
            item:item,
            directory:DVitaItemDirectory)
        
        Xml.data(object:model)
        { (data:Data?, error:XmlError?) in
            
            completion(data)
        }
    }
}
