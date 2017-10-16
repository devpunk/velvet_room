import Foundation
import XmlHero

final class MVitaXmlItem
{
    //MARK: private
    
    private init() { }
    
    private class func latestDirectories(
        items:[DVitaIdentifier]) -> [DVitaItemDirectory]
    {
        var directories:[DVitaItemDirectory] = []
        
        for item:DVitaIdentifier in items
        {
            guard
            
                let directory:DVitaItemDirectory = latestsDirectory(
                    item:item)
            
            else
            {
                continue
            }
            
            directories.append(directory)
        }
        
        return directories
    }
    
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
        items:[DVitaIdentifier],
        completion:@escaping((Data?) -> ()))
    {
        let directories:[DVitaItemDirectory] = latestDirectories(
            items:items)
        
        factoryXml(
            directories:directories,
            completion:completion)
    }
}
