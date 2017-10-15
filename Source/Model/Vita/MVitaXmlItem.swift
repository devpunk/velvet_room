import Foundation
import XmlHero

final class MVitaXmlItem
{
    //MARK: private
    
    private init() { }
    
    private class func latestsDirectory(
        item:DVitaIdentifier) -> DVitaItemDirectory?
    {
        guard
        
            let directory:DVitaItemDirectory = item.items?.lastObject as? DVitaItemDirectory
        
        else
        {
            return nil
        }
        
        return directory
    }
    
    //MARK: internal
    
    class func factoryMetadata(
        item:DVitaIdentifier,
        completion:@escaping((Data?) -> ()))
    {
        guard
        
            let directory:DVitaItemDirectory = latestsDirectory(
                item:item)
        
        else
        {
            return
        }
        
        factoryXml(
            item:item,
            directory:directory,
            completion:completion)
    }
}
