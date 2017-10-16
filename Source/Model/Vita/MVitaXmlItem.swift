import Foundation
import XmlHero

final class MVitaXmlItem
{
    //MARK: private
    
    private init() { }
    
    private class func factoryDirectories(
        items:[DVitaItem]) -> [DVitaItemDirectory]
    {
        var directories:[DVitaItemDirectory] = []
        
        for item:DVitaItem in items
        {
            guard
            
                let directory:DVitaItemDirectory = item as? DVitaItemDirectory
            
            else
            {
                continue
            }
            
            directories.append(directory)
        }
        
        return directories
    }
    
    //MARK: internal
    
    class func factoryMetadata(
        items:[DVitaItem],
        completion:@escaping((Data?) -> ()))
    {
        let directories:[DVitaItemDirectory] = factoryDirectories(
            items:items)
        
        factoryXml(
            directories:directories,
            completion:completion)
    }
}
